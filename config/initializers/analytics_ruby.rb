Analytics = Segment::Analytics.new({
    write_key: 'NWrab8JF5GlNuxs67uXRpbE4OnY8qfXN',
    on_error: Proc.new { |status, msg| print msg }
})
# This is the prod write key:   yrSIgmV7XdrdA5Bbg0ZdPfEabfQOcqq4