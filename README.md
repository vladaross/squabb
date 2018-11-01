# SQUABBLE

`Ruby 2.4.1`
`Rails 5.2`


#### SQUABBLE - is a type of forum engine with some special functions, like:
- Two sides discussion model
- Votes system for discussions, arguments and replies
- Different colors for each side of discussion
- Ability sort discussion by popularity, by time or by upvotes


#### WHAT YOU NEED TO RUN SQUABBLE:
- config/local_env.yml file with database setups:

	```
	DB_USER: 'user_example'
	DB_PASSWORD: 'mypass_example'
	HOST: 'host_example'
	```

- config/application.yml file with aws s3 setups:
(if you just want to run project localy you don't need this file)

	```
	S3_BUCKET_NAME: "BUCKET_NAME"
	AWS_ACCESS_KEY_ID: "ACCESS_KEY"
	AWS_SECRET_ACCESS_KEY: "SECRET_ACCESS_KEY"
	AWS_REGION: "AWS_REGION"
	AWS_HOST_NAME: "HOST_NAME"
	```

#### HOW TO RUN SQUABBLE:
1. Create postgres user
2. From project directory run `bundle install`
3. From project directory run `rake db:setup`
4. From project directory run `rails s`

#### HOW TO ADD ADMIN FOR SQUABBLE:

* Create some user(using console or just site registration)
* run in rails console `User.find(your_id).add_role(:admin)` or `User.where(username: your_username).add_role(:admin)`
