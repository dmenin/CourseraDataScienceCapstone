#http://thinktostart.com/analysis-of-twitter-devices-with-r/
api_key <- "zjtQwiqHGXg8qaCXTIa4x7OFx"
api_secret <- "phHgOkCVM1a5fXUP36qpcCv9Rot4FxzHqF5qABvjq3r1FWcpft"
access_token <- "45141109-rIXQxFLqM3FAtV4XKzlswxOzKbBL9zhwjkSDmpTh0"
access_token_secret <- "JExDufSFXeURJUalHTtDt1Z2RNgAsXDqwStlkLnwfnQ4k"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

tweets = searchTwitter("Social Media", n=1)
devices <- sapply(tweets, function(x) x$getStatusSource())


devices <- gsub("","", devices)
devices <- strsplit(devices, ">")
devices <- sapply(devices,function(x) ifelse(length(x) > 1, x[2], x[1]))

pie(table(devices))
