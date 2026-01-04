---
layout: page
title: Now
permalink: /now/
---
{% assign latest_now = site.now | sort: "date" | last %}
<p class="tagline">
  {{ site.now_tagline }}
</p>
<p class="meta">
  Updated: {{ latest_now.date | date: "%B %-d, %Y" }}
</p>

<article class="now-entry">
  {{ latest_now.content }}
</article>