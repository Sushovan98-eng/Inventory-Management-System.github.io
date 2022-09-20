FactoryBot.define do
  factory :issue do
    user_id {}
    item_id {}
    issue_description { 'MyString' }
  end
end
