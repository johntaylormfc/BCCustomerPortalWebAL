# Customer Portal Password API (CustomerPortal extension)

This extension adds a new field on the Customer record called **Portal Password** and exposes it via a **custom API page**.

## Prerequisites

1. Publish/install the **CustomerPortal** extension in the target Business Central environment.
2. Set a value for **Portal Password** on the customer (Customer Card → General → Portal Password).
3. Create/choose a service user (or Entra App registration user) that will call the API.
4. Assign permission set **CP Portal Auth** to that user.

## API details

The API page is defined as:

- `APIPublisher`: `cp`
- `APIGroup`: `portal`
- `APIVersion`: `v1.0`
- `EntitySetName`: `customerPortals`
- Key field: `Customer."No."` (because `ODataKeyFields = "No."`)

The API returns (at minimum) these properties:

- `no`
- `portalPassword`

## Request: Get the password for a given Customer No.

### URL pattern

Business Central API URLs follow this pattern:

```
.../api/{publisher}/{group}/{version}/{entitySet}('{customerNo}')
```

For **Business Central online (SaaS)** the base URL is:

```
https://api.businesscentral.dynamics.com/v2.0/{tenantId}/{environmentName}
```

Where:

- `{tenantId}` is your Entra tenant ID (GUID).
- `{environmentName}` is the BC environment name (for example `Production` or `Sandbox`).

So the full URL becomes:

```
https://api.businesscentral.dynamics.com/v2.0/{tenantId}/{environmentName}/api/cp/portal/v1.0/customerPortals('{customerNo}')
```

### Example (curl)

```bash
curl -X GET \
  "https://api.businesscentral.dynamics.com/v2.0/{tenantId}/{environmentName}/api/cp/portal/v1.0/customerPortals('10000')" \
  -H "Authorization: Bearer {access_token}" \
  -H "Accept: application/json"
```

Authentication note (SaaS):

- The caller typically authenticates using OAuth2 via Entra ID and supplies a `Bearer` access token scoped for Business Central.

### Example response

```json
{
  "@odata.context": "...",
  "no": "10000",
  "portalPassword": "example-password"
}
```

## Notes / gotchas

- **Customer No. quoting:** the key is an OData string key, so it must be in single quotes: `('10000')`.
- **URL encoding:** if your customer numbers can contain special characters, URL-encode them.
- **Security:** this API returns the password value as stored in Business Central. Treat it as sensitive data.
- **Permissions:** the calling user must have at least:
  - `tabledata Customer = R`
  - execute permission for the API page `CP Customer Portal API`

## Where this is implemented

- Customer field: [src/TableExtensions/CustomerPortalCustomerExt.al](src/TableExtensions/CustomerPortalCustomerExt.al)
- API page: [src/Pages/CustomerPortalCustomerApi.al](src/Pages/CustomerPortalCustomerApi.al)
- Permission set: [src/PermissionSets/CustomerPortalPortalAuth.permissionset.al](src/PermissionSets/CustomerPortalPortalAuth.permissionset.al)
