= Cooperative works \nfor \nFluentd Community

: author
  Kenji Okimoto\n
  Hiroshi Hatake

: institution
  ClearCode Inc.

: date
  2018-02-15

: theme
  .

: allotted-time
  25m

= Summary

  * kafka-connect-fluentd and its benckmarking result
  * maintaining fluentd plugins

= kafka-connect-fluentd?

  * Fluentd Forward Protocol Server implemented with Kafka Connect API
    * ((<kakfa-connect-fluentd|URL:https://github.com/fluent/kafka-connect-fluentd>))

= kafka-connect-fluentd?

  * Use ((<influent|URL:https://github.com/okumin/influent>)) for server implementation
    * Partial SSL/TLS support
  * Aim to replace output plugins in ((<fluent-plugin-kafka|URL:https://github.com/fluent/fluent-plugin-kafka>))

= Kafka Connect?

  # blockquote
  # title = Kafka Connect
  (('tag:x-small:Kafka Connect is a framework included in Apache Kafka that integrates Kafka with other systems.'))
  (('tag:x-small:Its purpose is to make it easy to add new systems to your scalable and secure stream data pipelines.'))

= Kafka Connect?

  * Kafka Connector Source ->\nKafka Producer
    * (('tag:x-small:I'll talk about this implementation.'))
  * Kafka Connector Sink ->\nKafka Consumer
    * (('tag:x-small:This implementation also exists.'))

= fluent-plugin-kafka

(('tag:xx-small'))

  # image
  # src = images/Fluentd-to-kafka-with-fluent-plugin-kafka.002.jpeg
  # relative_height = 100

= kafka-connect-fluentd

(('tag:xx-small'))

  # image
  # src = images/Fluentd-with-kafka-connect-fluentd.001.jpeg
  # relative_height = 100

= Difference

  # RT

  \n,(('tag:x-small:kafka-connect-fluentd')),(('tag:x-small:fluent-plugin-kafka'))
  language, Java, Ruby
  Run on, (('tag:small:Kafka side')),(('tag:x-small:Fluentd side'))

= (('tag:small:Requirements of benchmarking'))

  * (('tag:small:Easy to use benchmark test tool'))
  * (('tag:small:Reproducible'))
  * (('tag:small:Compare performance with same basis'))
    * (('note:Easy to confirm results'))

= (('tag:small:Easy to use benchmarking test tool'))

  * There is no tool which is easy to use from command line.
    * (('note:Dummer + in_tail exist, but it is hard to apply high load.'))

= Crated benchmark test tool

  * ((<fluent-benchmark-client|URL:https://github.com/okkez/fluent-benchmark-client>))
    * Implemented by Kotlin language
    * Sending log relies on ((<fluency|URL:https://github.com/komamitsu/fluency>))
      * (('note:SSL/TLS is not supported for now.'))

= Reproducible

  * (('tag:small:Built with Terraform + Ansible'))
    * Developing specific branch on ((<fluentd-benchmark|URL:https://github.com/okkez/fluentd-benchmark/tree/add-benchmark-using-gcp>))
       * (('note:Need to tidy up implementation'))

= (('tag:small:Compare performance\\nwith same basis'))

  * ((<kafka-fluent-metrics-reporter|URL:https://github.com/okkez/kafka-fluent-metrics-reporter>))
    * (('tag:x-small:Kafka plugin which sends Kafka metrics into Fluentd'))
  * (('tag:small:Write a script which parses result of pidstat and sends into Fluentd'))
    * (('tag:x-small:To measure CPU and memory usage'))

= (('tag:small:Benchmark environment'))

  # image
  # src = images/structure.svg
  # relative_height = 85

(('note:GCP n1-standard-2 (vCPUx2, memory 7.5GB)'))

= (('tag:small:out_kafka\\nCPU usage'))\n(('tag:x-small:10000 events/sec'))

  # image
  # src = images/out_kafka-max_buffer_size=1000-10k.png
  # relative_height = 80

(('note:out_kafka CPU usage is 40-60%'))

= (('tag:small:kafka-connect-fluentd\\nCPU usage'))\n(('tag:x-small:10000 events/sec'))

  # image
  # src = images/kafka-connect-fluentd-worker1-10k.png
  # relative_height = 80

(('note:kafka-connect-fluentd CPU usage is less than 20%'))

= (('tag:small:out_kafka_buffered\\n30000 events/sec'))

  # image
  # src = images/out_kafka_buffered-kafka_agg_max_bytes=4k-30k.png
  # relative_height = 80

(('note:out_kafka_buffered cannot process 30k events/sec'))

= (('tag:small:kafka-connect-fluentd\\n50000 events/sec'))

  # image
  # src = images/kafka-connect-fluentd-worker1-50k.png
  # relative_height = 80

(('note:kafka-connect-fluentd can process about 50k events/sec'))

= Benchmark results

  * (('tag:small:kafka-connect-fluentd can handle more 50,000 events/sec'))
  * (('tag:small:output plugin of fluent-plugin-kafka can handle 10,000 events/sec'))
    * (('note:cannot handle 30,000 events/sec in this environment'))


= Fluentd Community

  # image
  # src = images/plugin-list.png
  # relative_width = 50
  # align = right

(('tag:x-small:Fluentd community has lots of plugins'))\n(('tag:small:Over 700+ plugins'))

= Fluentd Community

  * Fluentd community has...
    * lots of up-to-date plugins
    * lots of outdated plugins

= Fluentd Community

  * Fluentd community has...
    * lots of up-to-date plugins
    * lots of ((*outdated*)) plugins

= How does handle outdated plugins?

  * Send PRs
  * Report issues
  * Become a maintainer

= What means ((*outdated*))?

  * out-of-date dependencies
    * c.f. client libraries
  * out-of-date class inheritance
    * (('Fluent::Input')), (('Fluent::HttpInput')) etc.

= What means ((*outdated*))?

  * Using old API
    * Gap between v0.12 and v1.0 API
  * ((*Fluent::Engine.emit*)) directly
  * Lack of requires etc.

= Maintaining Plugins

  * Normally, same as other rubygems

= Maintaining Plugins

  * Report issues
  * Send PRs

= Maintaining Plugins

  * 130+ PRs still opened...
  * 1400+ PRs merged
    * in 2.5 years

= Maintaining Plugins

  * But, sometimes plugin authors are busy....

= (('tag:small:Let\'s take over\\nFluentd plugins project'))

  * Ask plugin authors
    * to add project collaborator
    * to add gem owner
  * Create a cooperative working organization

= Become project collaborator

  * Maintaining only
    * takus/fluent-plugin-ec2-metadata
    * y-ken/fluent-plugin-anonymizer

= (('tag:small:Become project collaborator and gem owner'))

  * Still exists in original place, but maintaining ourselves
    * (('tag:x-small:uken/fluent-plugin-elasticsearch'))
    * (('tag:x-small:y-ken/fluent-plugin-geoip'))
    * (('tag:x-small:fluent/fluent-plugin-rewrite-tag-filter'))

= (('tag:small:Create cooperative working organization'))

  * (('tag:x-small:Take over outdated fluentd plugin project'))
  * (('tag:x-small:New plugins which will be widely used'))
     * (('note:c.f. fluent-plugin-concat'))
  * (('tag:x-small:And some collaborations'))

= (('tag:small:Create cooperative working organization'))

  * ((<fluent-plugins-nursery|URL:https://github.com/fluent-plugins-nursery>))

= fluent-plugins-nursery

  * (('tag:small:For Fluentd plugins that are not maintained by original authors'))
  * (('tag:small:Aim to provide a sustainable maintenance system for Fluentd community'))

= fluent-plugins-nursery

  * Almost plugins are taken over maintaining from original author.
    * fluent-plugin-map
    * fluent-plugin-redis
    * fluent-plugin-irc etc.

= fluent-plugins-nursery

  * Let's maintain fluentd plugins by community!
