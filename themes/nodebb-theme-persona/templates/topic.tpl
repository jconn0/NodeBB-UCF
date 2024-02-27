<div data-widget-area="header">
    {{{each widgets.header}}}
    {{widgets.header.html}}
    {{{end}}}
</div>
<div class="row" style="display: flex; flex-direction: row;">
    <div class="topic <!-- IF widgets.sidebar.length -->col-lg-9 col-sm-12<!-- ELSE -->col-lg-12<!-- ENDIF widgets.sidebar.length -->">
        <div class="topic-header">
            <h1 component="post/header" class="" itemprop="name">
                <span class="topic-title">
                    <span component="topic/labels">
                        <i component="topic/scheduled" class="fa fa-clock-o <!-- IF !scheduled -->hidden<!-- ENDIF !scheduled -->" title="[[topic:scheduled]]"></i>
                        <i component="topic/pinned" class="fa fa-thumb-tack <!-- IF (scheduled || !pinned) -->hidden<!-- ENDIF (scheduled || !pinned) -->" title="{{{ if !pinExpiry }}}[[topic:pinned]]{{{ else }}}[[topic:pinned-with-expiry, {pinExpiryISO}]]{{{ end }}}"></i>
                        <i component="topic/locked" class="fa fa-lock <!-- IF !locked -->hidden<!-- ENDIF !locked -->" title="[[topic:locked]]"></i>
                        <i class="fa fa-arrow-circle-right <!-- IF !oldCid -->hidden<!-- ENDIF !oldCid -->" title="{{{ if privileges.isAdminOrMod }}}[[topic:moved-from, {oldCategory.name}]]{{{ else }}}[[topic:moved]]{{{ end }}}"></i>
                        {{{each icons}}}{@value}{{{end}}}
                    </span>
                    <span component="topic/title">{title}</span>
                </span>
            </h1>

            <div class="topic-info clearfix">
                <div class="category-item inline-block">
                    <div role="presentation" class="icon pull-left" style="{function.generateCategoryBackground, category}">
                        <i class="fa fa-fw {category.icon}"></i>
                    </div>
                    <a href="{config.relative_path}/category/{category.slug}">{category.name}</a>
                </div>

                <div class="tags tag-list inline-block hidden-xs">
                    <!-- IMPORT partials/topic/tags.tpl -->
                </div>
                <div class="inline-block hidden-xs">
                    <!-- IMPORT partials/topic/stats.tpl -->
                </div>
                {{{ if !feeds:disableRSS }}}
                {{{ if rssFeedUrl }}}<a class="hidden-xs" target="_blank" href="{rssFeedUrl}"><i class="fa fa-rss-square"></i></a>{{{ end }}}
                {{{ end }}}
                {{{ if browsingUsers }}}
                <div class="inline-block hidden-xs">
                <!-- IMPORT partials/topic/browsing-users.tpl -->
                </div>
                {{{ end }}}

                <!-- IMPORT partials/post_bar.tpl -->
            </div>
        </div>
        <!-- IF merger -->
        <div component="topic/merged/message" class="alert alert-warning clearfix">
            <span class="pull-left">[[topic:merged_message, {config.relative_path}/topic/{mergeIntoTid}, {merger.mergedIntoTitle}]]</span>
            <span class="pull-right">
                <a href="{config.relative_path}/user/{merger.userslug}">
                    <strong>{merger.username}</strong>
                </a>
                <small class="timeago" title="{mergedTimestampISO}"></small>
            </span>
        </div>
        <!-- ENDIF merger -->

        {{{ if !scheduled }}}
        <!-- IMPORT partials/topic/deleted-message.tpl -->
        {{{ end }}}

        <ul component="topic" class="posts timeline" data-tid="{tid}" data-cid="{cid}">
            {{{each posts}}}
                <li component="post" class="{{{ if posts.deleted }}}deleted{{{ end }}} {{{ if posts.selfPost }}}self-post{{{ end }}} {{{ if posts.topicOwnerPost }}}topic-owner-post{{{ end }}}" <!-- IMPORT partials/data/topic.tpl -->>
                    <a component="post/anchor" data-index="{posts.index}" id="{posts.index}"></a>

                    <meta itemprop="datePublished" content="{posts.timestampISO}">
                    <meta itemprop="dateModified" content="{posts.editedISO}">

                    <!-- IMPORT partials/topic/post.tpl -->
                </li>
                {renderTopicEvents(@index, config.topicPostSort)}
            {{{end}}}
        </ul>

        {{{ if browsingUsers }}}
        <div class="visible-xs">
            <!-- IMPORT partials/topic/browsing-users.tpl -->
            <hr/>
        </div>
        {{{ end }}}

        <!-- IF config.enableQuickReply -->
        <!-- IMPORT partials/topic/quickreply.tpl -->
        <!-- ENDIF config.enableQuickReply -->

        <!-- IF config.usePagination -->
        <!-- IMPORT partials/paginator.tpl -->
        <!-- ENDIF config.usePagination -->

        <!-- IMPORT partials/topic/navigator.tpl -->
    </div>
    <div data-widget-area="sidebar" class="col-lg-3 col-sm-12 <!-- IF !widgets.sidebar.length -->hidden<!-- ENDIF !widgets.sidebar.length -->">
        {{{each widgets.sidebar}}}
        {{widgets.sidebar.html}}
        {{{end}}}
    </div>
    <div class="container" id="dictionary" style="width: 25%; display: none;">
        <h2 style="display: flex; justify-content: space-between;">Dictionary  <span id="close-btn" style="cursor: pointer;" onclick="hideDefinition()"><i class="fa fa-times fa-xs" aria-hidden="true"></i></span></h2>
        <h3><span id="word-header"></span><i class="fa fa-play-circle fa-xs" aria-hidden="true" id="play-pronounce" style="cursor: pointer; margin-left: 10px;"></i><h4 class="partOfSpeech">noun</h4></h3>
        <li>A challenge, trial.</li>
        <li>A cupel or cupelling hearth in which precious metals are melted for trial and refinement.</li>
        <b>Synonyms</b>: examination, quiz
        <h4 class="partOfSpeech">verb</h4>
        <li>To challenge.</li>
        <li>Climbing the mountain tested our stamina.</li>
    </div>
</div>

<div data-widget-area="footer">
    {{{each widgets.footer}}}
    {{widgets.footer.html}}
    {{{end}}}
</div>

<!-- IF !config.usePagination -->
<noscript>
    <!-- IMPORT partials/paginator.tpl -->
</noscript>
<!-- ENDIF !config.usePagination -->
