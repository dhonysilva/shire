# Shire

Application created during the process of learning how to develop applications utilizing the multitenacy capability with Ash Framework.


In other project we studied the `:context` strategy, which uses postgres schemas where each tenant has its own database schema. On this strategy we can fetch data from each tenant by using the schema name as a prefix. For example, to fetch the tickets from tenant_01, tenant_02 e tenant_03 we can run the following query:

```sql
select * from tenant_01.tickets;
select * from tenant_02.tickets;
select * from tenant_03.tickets;
```

## :attribute Multitenancy strategy

For this current project, we're utilizing the `:attribute` strategy described [here](https://hexdocs.pm/ash/multitenancy.html#attribute-multitenancy).
This strategy implies that each tenant has an attribute `organization_id` that is used to filter the data.

The Ticket resource thas the `organization_id` Foreign Key, which is used to determine which tenant it belongs to.

```
select * from tickets;
```

| id         | subject                | status | organization_id |
| ---------- | ---------------------- | ------ | --------------- |
| 0d96594d   | Cable doesn't work     | open   | 9e1c0c0a        |
| b6f8ffee   | Printer doesn't work   | open   | b948c8a3        |
| 69e44730   | Mouse doesn't work     | open   | b948c8a3        |
| 70c0d2ce   | Screen broken          | open   | 9e1c0c0a        |
| c74350d5   | Slow Internet          | close  | 9e1c0c0a        |
| 83b6c16d   | Fix the fan            | close  | 9e1c0c0a        |

Each organization represents one tenant on the application. The organizations table has the following structure:

```
select * from organizations;
```

| id         | name      | domain     |
| ---------- | --------- | ---------- |
| 9e1c0c0a   | Tenant 01 | tenant_01  |
| b948c8a3   | Tenant 02 | tenant_02  |



## Learn more
I walked through the official Ash Multitenacy documentation while developing this project.

https://hexdocs.pm/ash/multitenancy.html


Kamaro Lambert [(visit the project here)](https://github.com/kamaroly/helpdesk) provided two outstanding tutorials on how to work with Multitenancy utilizing the `:context` strategy and I used all of the instrunctions he provided to build this project. Here are the links to the tutorials:

- [Part 01](https://medium.com/@lambert.kamaro/how-to-build-a-saas-using-phoenix-and-ash-framework-1-4-69f3a622470d)
- [Part 02](https://medium.com/@lambert.kamaro/how-to-build-a-saas-using-phoenix-and-ash-framework-2-4-41ccbb8003fe)

### Setting up the project
To start this Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

The two routes available are:

  * [`localhost:4000/tickets/`](http://localhost:4000/tickets/)

  * [`localhost:4000/tickets/open`](http://localhost:4000/tickets/open)
