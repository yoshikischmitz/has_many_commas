# HasManyCommas

HasManyCommas allows you to take an active_record query, along with a symbol associated to a has_many association on that query's model, and gives a tabular representation of each parent record row along with all of its child records appended as extra columns. 

For example, say you have a user model:

	user = User.create(username: "zoroaster")

A user can have many comments:

	user.comments.build({content: "FIRST POST!"}, {content: "Sorry I haven't posted in a long time"})
	user.save

If we use HasManyCommas, supplying it with a filename, query and an association:

	HasManyCommas::to_file("./users_and_comments.csv", User.all, :comments)

HasManyCommas will create a CSV file like this:

| user_id | user_username | user_created_at | user_updated_at | user_comments_1_id | user_comments_1_content | user_comments_1_created_at | user_comments_1_updated_at | user_comments_2_id | user_comments_2_content | user_comments_2_created_at | user_comments_2_updated_at|
------- | ------------- | --------------- | --------------- | ------------------ | ----------------------- | -------------------------- | -------------------------- | ------------------ | ----------------------- | -------------------------- | -------------------------- |
|1      | zoroaster     | 2014-07-29 00:10:56 UTC | 2014-07-29 00:10:56 UTC | 2  | FIRST POST!             | 2014-07-29 00:10:56 UT     | 2014-07-29 00:10:56 UT     | 3                  | Sorry I haven't posted in a long time | 2014-07-29 00:10:56 UT | 2014-07-29 00:10:56 UT |

(Note: default write mode is 'w+', see below for other options)

For the child columns, HasManyCommas will only generate as many columns as necessary. If for example out of your many users, one of them had 100 comments, the final last column would be something like: `user_comments_100_updated_at`

However if you need more control over your output's format, and have some kind of file object that responds to `<<`, like some of the excel spreadsheet gems offer, you can also just supply that to `to_file`:

	# Write CSV in append mode:
	csv = CSV.open("./results.csv", "a+")
	HasManyCommas::to_file(csv, User.all, :comments)

If you just want an array of rows, call `HasManyCommas::flatten_query(User.all, :comments)`.

## Installation

Add this line to your application's Gemfile:

    gem 'has_many_commas', git: "https://github.com/Takemikazuchi/has_many_commas"

## Contributing

1. Fork it ( https://github.com/takemikazuchi/has_many_commas/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
