Analytics = Segment::Analytics.new({
    write_key: 'NWrab8JF5GlNuxs67uXRpbE4OnY8qfXN',
    on_error: Proc.new { |status, msg| print msg }
})
