using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Windows;
using Xceed.Document.NET;
using Xceed.Words.NET;

namespace ZENEVICH_OKR_2_VARIANT_9
{
    public partial class MainWindow : Window
    {
        private readonly string ConnectionString = "Data Source=SNGLRTYCRV;Initial Catalog=Metals-Service;User Id=sa;password=TbAlu5ZE2Y8l;MultipleActiveResultSets=true;TrustServerCertificate=True";
        private readonly SqlDataAdapter adapter;
        private readonly DataTable dataTable;

        public MainWindow()
        {
            InitializeComponent();
            dataTable = new DataTable();
            adapter = new SqlDataAdapter("SELECT * FROM Metals", ConnectionString);

            adapter.Fill(dataTable);

            dataGrid.ItemsSource = dataTable.DefaultView;
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            DataRow newRow = dataTable.NewRow();
            dataTable.Rows.Add(newRow);
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                SqlCommandBuilder builder = new SqlCommandBuilder(adapter);
                adapter.Update(dataTable);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при сохранении данных: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void DeleteButton_Click(object sender, RoutedEventArgs e)
        {
            if (dataGrid.SelectedItem is DataRowView selectedRow)
            {
                selectedRow.Row.Delete();
            }
        }

        private void ShowTemperatureHigherDensity(object sender, RoutedEventArgs e)
        {
            string query = "SELECT Металл, ТемператураПлавления, Плотность FROM Metals WHERE ТемператураПлавления > Плотность";
            ShowQueryResultsWindow(query);
        }

        private void ShowMinThermalConductivity(object sender, RoutedEventArgs e)
        {
            string query = "SELECT TOP 1 Металл, УдельнаяТеплопроводность FROM Metals ORDER BY УдельнаяТеплопроводность ASC";
            ShowQueryResultsWindow(query);
        }

        private void ShowThermalConductivityInRange(object sender, RoutedEventArgs e)
        {
            double minConductivity = double.Parse(minTextBox.Text);
            double maxConductivity = double.Parse(maxTextBox.Text);

            string query = $"SELECT Металл, УдельнаяТеплопроводность FROM Metals WHERE УдельнаяТеплопроводность BETWEEN {minConductivity} AND {maxConductivity}";
            ShowQueryResultsWindow(query);
        }

        private void ShowQueryResultsWindow(string query)
        {
            DataTable resultTable = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                using (SqlDataAdapter resultAdapter = new SqlDataAdapter(query, connection))
                {
                    resultAdapter.Fill(resultTable);
                }
            }

            QueryResultsWindow resultsWindow = new QueryResultsWindow(resultTable);
            resultsWindow.Show();
        }

        private void GenerateReport_Click(object sender, RoutedEventArgs e)
        {
            DataTable reportTable = dataTable.AsEnumerable()
                .Where(row => Convert.ToDecimal(row["УдельнаяТеплопроводность"]) > 75)
                .OrderByDescending(row => Convert.ToDecimal(row["УдельнаяТеплопроводность"]))
                .CopyToDataTable();

            using (DocX document = DocX.Create("Report.docx"))
            {
                document.InsertParagraph("Отчёт о металлах с удельной теплопроводностью больше 75").FontSize(14).Bold();

                AddTableToDocument(document, reportTable);

                double averageDensity = dataTable.AsEnumerable().Average(row => Convert.ToDouble(row["Плотность"]));
                DataRow metalWithMaxMeltingPoint = dataTable.AsEnumerable().OrderByDescending(row => Convert.ToInt32(row["ТемператураПлавления"])).First();

                document.InsertParagraph("\nИтоги:").FontSize(12).Bold();
                document.InsertParagraph($"Средняя плотность всех металлов: {averageDensity:F2} г/см³");
                document.InsertParagraph($"Металл с наибольшей температурой плавления: {metalWithMaxMeltingPoint["Металл"]} ({metalWithMaxMeltingPoint["ТемператураПлавления"]} °C)");

                document.Save();
            }

            MessageBox.Show("Отчёт сгенерирован и сохранён в файл Report.docx", "Отчёт сгенерирован", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        private void AddTableToDocument(DocX document, DataTable dataTable)
        {
            Table table = document.AddTable(dataTable.Rows.Count + 1, dataTable.Columns.Count);
            table.Alignment = Alignment.center;
            table.Design = TableDesign.TableGrid;

            for (int col = 0; col < dataTable.Columns.Count; col++)
            {
                table.Rows[0].Cells[col].Paragraphs.First().Append(dataTable.Columns[col].ColumnName).Bold();
            }

            for (int row = 0; row < dataTable.Rows.Count; row++)
            {
                for (int col = 0; col < dataTable.Columns.Count; col++)
                {
                    table.Rows[row + 1].Cells[col].Paragraphs.First().Append(dataTable.Rows[row][col].ToString());
                }
            }

            document.InsertTable(table);
        }
    }
}
