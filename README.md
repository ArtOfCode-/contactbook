# contactbook
If you feel like running this in your own environment:

1. **Load the gems**  
  As always... `bundle install` the required gems.

2. **Set up the database**  
  - Create the database and user, add the credentials to `config/database.yml`.
  - Run `rake db:schema:load` to load the schema into the database.

3. **Run the application**  
  As usual, run `rails s` to start the server; it should work on any port or binding.

4. **Create an administrator**  
  Sign up for an account, then in your database, run

        update users set is_admin = 1 where id = <id>;

  replacing `<id>` with your actual user ID.

Done!

### Versions
- Ruby: `2.2.1p85`
- Rails: `4.2.6`
- SQLite: `3.8.2`

All other versions should be available to read in the Gemfile.

### License
Dual-licensed under either of

- [the MIT license](http://choosealicense.com/licenses/mit/)
- [Apache 2.0](http://choosealicense.com/licenses/apache-2.0/)

For full details and copyright notices, see the LICENSE-MIT and LICENSE-APACHE files.
