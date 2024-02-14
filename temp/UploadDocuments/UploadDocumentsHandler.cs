using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using AutoMapper;
using MediatR;
using Solidex.Api.Company.Services;
using Solidex.Api.Files;
using Solidex.Company.Data;

namespace Solidex.Company.Commands.CompanyController.UploadDocuments;

public class UploadDocumentsHandler : IRequestHandler<UploadDocumentsRequest, UploadDocumentsResponse>
{
    private readonly CompanyDbContext _context;
    private readonly IMapper _mapper;
    private readonly ICompanyApi _companyApi;
    private readonly IFolderApi _folderApi;

    public UploadDocumentsHandler(CompanyDbContext context, IMapper mapper, ICompanyApi companyApi, 
        IFolderApi folderApi)
    {
        _context = context;
        _mapper = mapper;
        _companyApi = companyApi;
        _folderApi = folderApi;
    }
    
    public async Task<UploadDocumentsResponse> Handle(UploadDocumentsRequest request, 
        CancellationToken cancellationToken)
    {
        var company = await _companyApi.GetCompanyByShortcutAsync(request.Shortcut);
        
        var documents = _mapper.Map<List<FileEntity>>(request.FileIds);
        
        var awsVerificationResult = await VerifyDocumentsInAwsAsync(documents);
        
        if (awsVerificationResult)
        {
            // Если документы удовлетворяют требованиям, обновляем статус компании
            company.Verified = true;
            _context.Update(company);
            await _context.SaveChangesAsync(cancellationToken);

            // Отправляем сообщение о подтверждении
            await SendVerificationConfirmationAsync(company);

            // Присваиваем роль владельца компании пользователю
            var companyOwner = _context.CompanyContacts
                .FirstOrDefault(c => c.CompanyId == company.Id && c.UserInformationId == request.UserInformationId);

            if (companyOwner != null)
            {
                // Предполагаем, что у вас есть модель для хранения данных о ролях пользователей
                var userGroup = new UserGroupEntity
                {
                    GroupId = companyOwner.Id,
                    UserInformationId = request.UserInformationId
                };

                _context.UserGroups.Add(userGroup);
                await _context.SaveChangesAsync(cancellationToken);
            }

            return new UploadDocumentsResponse { Message = "Компания подтверждена и доступ разрешен." };
        }
        else
        {
            // Если документы не удовлетворяют требованиям, отправляем сообщение об отклонении
            await SendVerificationRejectionAsync(company);

            return new UploadDocumentsResponse { Message = "Документы не удовлетворяют требованиям." };
        }
        
        var postFolderRequest = new PostFolderRequest
        {
            Id = company.Content.Item.Id,
            CompanyId = company.Content.Item.Id,
            FolderName = $"{company.Content.Item.Id}:{company.Content.Item.Shortcut} - temp",
            ParentId = company.FolderId
        };

        var postFolderResponse = await _folderApi.PostFolderAsync(company.Content.Item.Id, company.Content.Item.Id, 
            null, postFolderRequest, null, cancellationToken);
        
        
    }
    
    private async Task<bool> VerifyDocumentsInAwsAsync(List<DocumentEntity> documents)
    {
        // Здесь должен быть код отправки документов на проверку в AWS
        // Возвращайте true, если документы прошли проверку, и false в противном случае
        // На момент написания ответа, у меня нет конкретной реализации AWS-проверки
        return true;
    }

    private async Task SendVerificationConfirmationAsync(CompanyEntity company)
    {
        // Здесь должен быть код отправки уведомления о подтверждении
        // Например, использование сервиса уведомлений или отправка email
    }

    private async Task SendVerificationRejectionAsync(CompanyEntity company)
    {
        // Здесь должен быть код отправки уведомления об отклонении
        // Например, использование сервиса уведомлений или отправка email
    }
}