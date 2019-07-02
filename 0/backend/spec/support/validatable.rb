module Helpers
  module Validatable
    def blank_values
      ['', ' ', "\n", "\r", "\t", "\f"]
    end

    def valid_urls # rubocop:disable Metrics/MethodLength
      [
        'http://foo.com/blah_blah',
        'http://foo.com/blah_blah/',
        'http://www.example.com/wpstyle/?p=364',
        'https://www.example.com/foo/?bar=baz&inga=42&quux',
        'http://userid:password@example.com:8080',
        'http://userid:password@example.com:8080/',
        'http://userid@example.com',
        'http://userid@example.com/',
        'http://userid@example.com:8080',
        'http://userid@example.com:8080/',
        'http://userid:password@example.com',
        'http://userid:password@example.com/',
        'http://142.42.1.1/',
        'http://142.42.1.1:8080/',
        'http://code.google.com/events/#&product=browser',
        'http://j.mp',
        'http://foo.bar/?q=Test%20URL-encoded%20stuff',
        'http://1337.net',
        'http://a.b-c.de'
      ]
    end

    def invalid_urls
      ['//', '//a', '///a', '///', 'foo.com', ':// should fail']
    end
  end
end
