require "clockwork"
require_relative "../config/boot"
require_relative "../config/environment"

include Clockwork

# Use locks so multiple clock processes do not schedule dupes
every(10.seconds, "clockwork.very_frequent") do
  if RedisLock.acquire("clockwork:send_stats:v3", 8)
    SendStats.perform_async
  end

  if RedisLock.acquire("clockwork:warm_cache", 8)
    WarmCache.perform_async(nil, true)
  end
end

every(1.minutes, "clockwork.frequent") do
  if RedisLock.acquire("clockwork:feed:refresher:scheduler:v2")
    FeedRefresherScheduler.perform_async
  end

  if RedisLock.acquire("clockwork:harvest:embed:data")
    HarvestEmbedData.perform_async
  end
end

every(1.day, "clockwork.daily", at: "7:00", tz: "UTC") do
  if RedisLock.acquire("clockwork:delete_entries:v2")
    EntryDeleterScheduler.perform_async
  end

  if RedisLock.acquire("clockwork:trial_expiration:v2")
    TrialExpiration.perform_async
  end

  if RedisLock.acquire("clockwork:twitter_validate_credentials")
    TwitterValidateCredentials.perform_async
  end

  if RedisLock.acquire("clockwork:web_sub_maintenance")
    WebSubMaintenance.perform_async
  end
end
