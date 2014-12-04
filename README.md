# HasManyCommas

TODO: Write a gem description

HasManyCommas allows you to take an active_record query, along with a symbol associated to a has_many association on that query's model, and gives a tabular representation of each parent record row along with all of its child records appended as extra columns. 

For example, say you have a user model:

	user = User.create(username: "zoroaster")

A user can have many comments:

	user.comments.build({content: "FIRST POST!"}, {content: "Sorry I haven't posted in a long time"})
	user.save

If we use HasManyCommas, supplying it with a query and an association:

	HasManyCommas::to_csv("./users_and_comments.csv", User.all, :comments)

We'll get a file like this:

| user_id | user_username | user_created_at | user_updated_at | user_comments_1_id | user_comments_1_content | user_comments_1_created_at | user_comments_1_updated_at | user_comments_2_id | user_comments_2_content | user_comments_2_created_at | user_comments_2_updated_at|
------- | ------------- | --------------- | --------------- | ------------------ | ----------------------- | -------------------------- | -------------------------- | ------------------ | ----------------------- | -------------------------- | -------------------------- |
|1      | zoroaster     | 2014-07-29 00:10:56 UTC | 2014-07-29 00:10:56 UTC | 2  | FIRST POST!             | 2014-07-29 00:10:56 UT     | 2014-07-29 00:10:56 UT     | 3                  | Sorry I haven't posted in a long time | 2014-07-29 00:10:56 UT | 2014-07-29 00:10:56 UT |

For the child columns, HasManyCommas will only generate as many columns as necessary. If your query includes one record with 12 more associated records, the last column will be `parent_association_12_attriubte`.

If you need the data in something other than CSV, you can call `HasManyCommas::flatten_query(User.all, :comments)` and get an array of rows to process them elsewhere.

## Installation

Add this line to your application's Gemfile:

    gem 'has_many_commas'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install has_many_commas

## Contributing

1. Fork it ( https://github.com/[my-github-username]/has_many_commas/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
