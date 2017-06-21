---
title: The Simplest Backup Solution For Me
description: Cross-platform, simple, scriptable, schedulable with rclone and Amazon Cloud Drive
published: false
date: 2016-09-13
---

I've used just about every consumer remote backup service available in the last 10 years. Mozy, BackBlaze and Crashplan were all fine for basic usage but since building a [FreeNAS][freenas] server and moved terabytes of photos and video I've taken over the years to it, those services' convoluted client apps and slow uploads are causing me grief.

The latest is Crashplan, which uses a Java-based client that only supports Windows, OS X and Linux, meaning I've been running an Ubuntu VM on the server just for backups. A lot of overhead for just uploads. It's also slow, It's taken months to upload about half of the files I have selected for backup.

Enter [rclone][rclone], a simple command line tool written for remote backups written in Go that supports many services and has binaries for every major OS. You pass it a directory and where you want to upload it to and it does just that.

I've chosen [Amazon Cloud Drive][acd] as my destination, mostly for the price: $30 USD a year for unlimited storage. Files are also accessible through mobile apps and a web interface very similar to DropBox.

[freenas]:http://www.freenas.org
[rclone]:http://rclone.org
[acd]:https://www.amazon.ca/clouddrive
