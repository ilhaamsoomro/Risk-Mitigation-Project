using { RiskManagement as my } from '../db/schema.cds';

using { API_BUSINESS_PARTNER as BusinessPartner }
service ExternalService {
  entity BusinessPartners as projection on BusinessPartner.A_BusinessPartner;
}

@path : '/service/RiskManagementService'
service RiskManagementService
{
}

annotate RiskManagementService with @requires :
[
    'authenticated-user'
];
