# rails_csv_renderer

[![Build Status](https://travis-ci.org/den-sheleh/rails_csv_renderer.svg?branch=master)](https://travis-ci.org/den-sheleh/rails_csv_renderer)
[![Code Climate](https://codeclimate.com/github/den-sheleh/rails_csv_renderer.png)](https://codeclimate.com/github/den-sheleh/rails_csv_renderer)
[![Gem Version](https://badge.fury.io/rb/rails_csv_renderer.svg)](http://badge.fury.io/rb/rails_csv_renderer)

Custom CSV renderer for ActiveRecord collections

## Rails & Ruby Versions Supported

*Rails:* 4.x

*Ruby:* 2.x

## Installation

Add this line to your application's Gemfile:

    gem 'rails_csv_renderer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_csv_renderer

## Usage

The rails_csv_renderer allows you to render any collection as CSV data. Result CSV includes all columns of model with localized column's names

```ruby
class ReportsController < ApplicationController
  def index
    @reports = Report.all

    respond_to do |format|
      format.csv  { render csv: @reports }
    end
  end
end
```

Will render a CSV file similar to:

<table>
  <tr>
    <th>Title</th><th>Content</th><th>Created at</th><th>Updated at</th>
  </tr>
  <tr>
    <td>House report</td><td>Report about house devices</td><td>2014-07-14 01:00:42 UTC</td><td>2014-07-14 01:00:42 UTC</td>
  </tr>
  <tr>
    <td>Work report</td><td>Report about work devices</td><td>2014-07-14 12:42:42 UTC</td><td>2014-07-14 12:42:42 UTC</td>
  </tr>
</table>

### Options

You can pass few options at call of rendrer:

* *:filename* - Name of file. Optional
* *:csv_options* - Options for CSV generator. [Availible options](http://www.ruby-doc.org/stdlib-2.1.2/libdoc/csv/rdoc/CSV.html#method-c-new). Optional
* *:columns* - Array of variables and methods. Title of columns will be created based on your translations. In this case you should not define methods in model. Optional

Example

```ruby
class ReportsController < ApplicationController
  def index
    @reports = Report.all

    respond_to do |format|
      format.csv  { render csv: @reports, filename: 'custom-reports.csv', csv_options: { col_sep: '\t' }, columns: [:created_at, :title] }
    end
  end
end
```

### Localize column's names

If you have translations for model's attributes under scope [:activerecord, :attributes, \*model_name\*] names of columns will be
automatically translated.

### Customize CSV

To customize your CSV file with different methods and name of columns you should add next methods to model **csv_header**(class method), **csv_row**.

* **csv_header** should return array with column's titles.

* **csv_row** should return array with values for columns.

```ruby
class Cat < ActiveRecord::Base
  def self.csv_header
    ["ID", "Cat's name"]
  end

  def csv_row
    [id, name]
  end
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rails_csv_renderer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
