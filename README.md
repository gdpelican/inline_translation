# Babbel

Babbel is a gem which provides your application with a simple, easy-to-use way to perform inline translations of content, into a variety of languages.

It's written as a wrapper for the fine [bing_translator gem](https://github.com/relrod/bing_translator-gem), but can be easily extended to using other translation services.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'babbel'
```

And then execute:

    $ bundle

Then, execute the install generator

    $ rails g babbel:install

And migrate

    $ rake db:migrate

Now you're all set up!

## Usage

Babbel supplies several helper methods to make your translating life easier.

To mark a field on an object as translatable, simply add

`acts_as_translatable, on: :field_name`

to your model.

#### Additional options

**load_via** - the class method used to find a record for your model. Defaults to `:find`
**id_field** - field name for the unique identifier for your model. Defaults to `:id`
**language_field** - field name for the method / column name on your model to retrieve the language. Defaults to `language`

NB: Oftentimes, you may wish to delegate this method to a user or other object, instead of storing the language on every model.

For example:

```
# model.rb
class Model < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  acts_as_translatable on: :column

  def language
    user.locale
  end
```

## On the frontend

Babbel provides a simple helper method for translation links in the view.

For example, adding

`translate_link_for(@model, to: :fr)`

Will add an ajax link to create and store a French translation. The `to` field will default to I18n.locale.

#### Additional options

**text** - The text of the anchor generated. Defaults to 'Translate'

## On the backend

Babbel uses the Bing Translator API as a default. For instructions on setting up the Bing Translator API, [go here](https://github.com/relrod/bing_translator-gem#getting-a-client-id-and-secret).

## Different Translators

Babbel uses the Bing Translator as a default translator, you can very easily write yous  own.

Simply change the line in `config/initializers/babbel.rb` to use whatever translator you desire.

Note that a custom translator must implement the following methods:

- `self.ready?`: Returns true if the translator can translate anything
- `can_translate?`: Returns true the translator can translate the given translatable
- `translate`: Returns a translation for all `acts_as_translatable` fields on the translatable

## Contributing

1. Fork it ( https://github.com/[my-github-username]/babbel/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
