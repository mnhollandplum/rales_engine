This is an API to access data from the SalesEngine using JSON and FastJSON API by Amazon.

To collaborate on this project:

git clone git@github.com:mnhollandplum/rales_engine.git

run:
* bundle
* bundle update
* bundle exec rake db:{create,migrate}
* bundle exec rake import:data (this may take a few minutes)

from the command line

Testing:

To run the included test:
* rspec

from the command line

To run the spec harness:
* Create a root folder with the project folder inside
* git clone git@github.com:turingschool/rales_engine_spec_harness.git
* run rails s while in the project folder in the terminal
* then run rake while in the spec harness folder in the terminal
