using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace ZENEVICH_OKR_2_VARIANT_9
{
    /// <summary>
    /// Логика взаимодействия для QueryResultsWindow.xaml
    /// </summary>
    public partial class QueryResultsWindow : Window
    {
        private readonly DataTable resultTable;

        public QueryResultsWindow(DataTable table)
        {
            InitializeComponent();
            resultTable = table;

            dataGrid.ItemsSource = resultTable.DefaultView;
        }
    }
}
