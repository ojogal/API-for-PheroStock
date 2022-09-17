# API-for-PheroStock


## Setup
```
git clone https://github.com/ojogal/API-for-PheroStock.git
bundle install
rails db:setup
rails s -p 4001 
```
## Usage

Create user
```
curl -X POST -d 'user[email]=user@email.com' -d 'user[password]=1111' localhost:4001/api/v1/users
```

Obtain token
```
curl -X POST -d 'user[email]=user@email.com' -d 'user[password]=1111' localhost:4001/api/v1/tokens
```

Manage company
```
export TKN="fyKibH...XrbZBdoB"
curl -X POST -H "Authorization: $TKN" -d "company[company_name]=MyCompanyName" localhost:4001/api/v1/companies
# show
curl -H "Authorization: $TKN" localhost:3000/api/v1/companies
# delete
curl -X DELETE -H "Authorization: $TKN" localhost:3000/api/v1/companies/1
```

Manage chemicals
```
curl -X POST -H "Authorization: $TKN" -d "chemical[chemical_name]=MyChemicalName" -d "chemical[synonym]=MySynonym" -d "chemical[cas]=1234-123" localhost:4001/api/v1/chemicals
```



