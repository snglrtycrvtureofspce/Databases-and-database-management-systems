using System;
using System.Collections.Generic;
using MediatR;

namespace Solidex.Company.Commands.CompanyController.UploadDocuments;

public class UploadDocumentsRequest : IRequest<UploadDocumentsResponse>
{
    public string Shortcut { get; init; }
    public Guid UserInformationId { get; init; }
    public List<Guid> FileIds { get; init; }
}