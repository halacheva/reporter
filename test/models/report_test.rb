require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'should not allow report without title, description, body and location' do
    report = Report.new

    assert report.invalid?, 'report without an attribute should not be valid'
    assert report.errors[:title].any?, 'report without title should not be valid'
    assert report.errors[:description].any?, 'report without description should not be valid'
    assert report.errors[:body].any?, 'report without body should not be valid'
    assert report.errors[:location].any?, 'report without location should not be valid'
  end

  test 'should allow report with title length >= 2 chars' do
    report = Report.new title: 't',
                        description: 'report description',
                        body: 'body',
                        location: 'location'

    assert report.invalid?
    assert report.errors[:title].any?, 'report with name length < 2 chars should not be valid'

    report.title = 'title'
    assert report.valid?, 'report with name length >= 2 chars should be valid'
  end

  test 'should allow report with description length >= 10 chars' do
    report = Report.new title: 'title',
                        description: 'desc',
                        body: 'body',
                        location: 'location'

    assert report.invalid?
    assert report.errors[:description].any?,
           'report with description length < 10 chars should not be valid'

    report.description = 'report description'
    assert report.valid?, 'report with description length >= 10 chars should be valid'
  end

  test 'should allow report with location which contains only letters and spaces' do
    report = Report.new title: 'title',
                        description: 'report description',
                        body: 'body',
                        location: 'location9!!!!'

    assert report.invalid?
    assert report.errors[:location].any?,
           'report location which does not contain only letters and spaces should not be valid'

    report.location = 'Sofia'
    assert report.valid?, 'report location which contains only letters should be valid'

    report.location = 'New York'
    assert report.valid?, 'report location which contains only letters and spaces should be valid'
  end
end
