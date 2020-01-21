# Sales

## Using it
Install gems
`$ bundle install`

Create database and demo data
`$ rake db:drop && rake db:create && rake db:migrate && rake db:seed`

Run the appication
`rails s`

Visit api docs on
`http://localhost:3000/api/docs`

Visit home page
`http://localhost:3000`

#### Or, build it in your own image

Build your image
`$ docker build -t sales_dashboard .`

Build container
`$ docker run --restart=always -p 4000:4000 -d -it sales_dashboard`

Visit api docs on
`http://localhost:4000/api/docs`

Visit home page
`http://localhost:4000`
