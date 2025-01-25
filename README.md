# Shire

Application created during the process of learning how to develop applications utlizing the multitenacy capability with Ash Framework.


In other project we studied the `:context` strategy, which uses postgres schemas where each tenant has its own database schema. On this strategy We can fetch the data from each tenant by using the schema name as a prefix. For example, to fetch the tickets from tenant_01, tenant_02 e tenant_03 we can run the following query:

```sql
select * from tenant_01.tickets;
select * from tenant_02.tickets;
select * from tenant_03.tickets;
```

## :attribute Multitenancy strategy

For this current project, we're utilizing the `:attribute` strategy described [here](https://hexdocs.pm/ash/multitenancy.html#attribute-multitenancy).
This strategy implies that each tenant has an attribute `organization_id` that is used to filter the data.





## Learn more
I walked through the official Ash Multitenacy documentation while developing this project:

https://hexdocs.pm/ash/multitenancy.html



### Setting up the project
To start this Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
