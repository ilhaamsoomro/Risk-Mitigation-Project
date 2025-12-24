namespace RiskManagement;

using { managed } from '@sap/cds/common';


entity Risks : managed {
    key ID : UUID;
    title : String(120);
    descr : String(500);
    category : String(40);  
    impact : Integer;
    likelihood : Integer;
    score : Integer;
    status : String(20); // Draft, Submitted, Approved, Mitigating, Closed
    ownerID : UUID;  // FK to RiskOwners

    // Association to the junction table (RiskMitigationLinks)
    mitigations : Association to many RiskMitigationLinks on mitigations.riskID = $self.ID;

    
  // Optional external context
  extContext         : Association to ExternalContext
                       on extContext.riskID = $self.ID;

}

entity Mitigations {
    key ID : UUID;
    title : String(120);
    createdAt : String(100);
    createdBy : String(100);
    description : String(100);
    owner : String(100);
    timeline : String(100);

    // Association to the junction table (RiskMitigationLinks)
    riskLinks : Association to many RiskMitigationLinks on riskLinks.mitigationID = $self.ID;
}


// Junction table entity for many-to-many relationship
entity RiskMitigationLinks {
    
    key riskID : UUID;  // Foreign key to Risks
    key mitigationID : UUID;  // Foreign key to Mitigations

    // Reverse associations to Risks and Mitigations
    risk : Association to Risks on risk.ID = $self.riskID;  // Reverse association to Risks
    mitigation : Association to Mitigations on mitigation.ID = $self.mitigationID;  // Reverse association to Mitigations
}

entity RiskOwners {
    key ID : UUID;
    name : String(100);
    email : String(100);
    department : String(60);
    risks : Association to many Risks on risks.ownerID = $self.ID
}

entity ExternalContext {
    key ID : UUID;
    riskID : UUID;
    supplierID : String(40);
    poID : String(40);
    currency : String(3);
    fxRate : Decimal(15,6);
    weatherSeverity : Integer;
    notes : String(300);

    risk : Association to Risks on risk.ID = $self.ID;
}