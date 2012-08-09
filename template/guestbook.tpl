{combine_css path=$GUESTBOOK_PATH|@cat:"template/style.css"}

{if $comment_add.ACTIVATE_RATING}
  {combine_script id="jquery.raty" path=$GUESTBOOK_PATH|@cat:"template/jquery.raty/jquery.raty.min.js"}
  {footer_script}
  jQuery("#comment_rate").raty({ldelim}
    path: "{$ROOT_URL}{$GUESTBOOK_PATH}template/jquery.raty/",
    half: true
  });
  {/footer_script}
{/if}

{footer_script}
jQuery("#expandForm").click(function() {ldelim}
  jQuery("#guestbookAdd").animate({ldelim}"width": "500px"}, function() {ldelim}
    jQuery("#addComment").slideDown("slow");
  });
});
{/footer_script}


{* <!-- Menubar & titrePage --> *}
{if $themeconf.name == "stripped" or $themeconf.parent == "stripped"}
  {include file=$ABS_GUESTBOOK_PATH|@cat:'template/themes/stripped.tpl'}
  {assign var="clear" value="true"}
{elseif $themeconf.name == "simple-grey" or $themeconf.parent == "simple"}
  {include file=$ABS_GUESTBOOK_PATH|@cat:'template/themes/simple.tpl'}
  {assign var="clear" value="true"}
{else}
  {include file=$ABS_GUESTBOOK_PATH|@cat:'template/themes/default.tpl'}
{/if}

{if isset($errors) or not empty($infos)}
{include file='infos_errors.tpl'}
{/if}


{if isset($comment_add)}
<div id="guestbookAdd">
<h4 id="expandForm">{'Sign the guestbook'|@translate}</h4>
<form method="post" action="{$comment_add.F_ACTION}" id="addComment" style="display:none;">
  <table>
  {if $comment_add.SHOW_AUTHOR}
    <tr>
    <td>
      <p><label for="author">{'Author'|@translate}* :</label></p>
      <p><input type="text" name="author" id="author" value="{$comment_add.AUTHOR}"></p>
    </td>
    <td>
      <p><label for="email">{'Email address'|@translate} ({'not publicly visible'|@translate}) :</label></p>
      <p><input type="text" name="email" id="email" size="30" value="{$comment_add.EMAIL}"></p>
    </td>
    </tr>
  {/if}
    <tr>
  {if $comment_add.ACTIVATE_RATING}
    <td>
      <p>{'Rate'|@translate} :</p>
      <p><span id="comment_rate"></span></p>
    </td>
  {/if}
    <td>
      <p><label for="website">{'Website'|@translate} :</label></p>
      <p><input type="text" name="website" id="website" size="30" value="{$comment_add.WEBSITE}"></p>
    </td>
    </tr>
  </table>
  
  <p><label for="contentid">{'Comment'|@translate}* :</label></p>
  <p><textarea name="content" id="contentid" rows="10" style="width:100%;">{$comment_add.CONTENT}</textarea></p>
  <p><input type="hidden" name="key" value="{$comment_add.KEY}">
    <input type="submit" value="{'Submit'|@translate}"> {'* : mandatory fields'|@translate}</p>
</form>
</div>
{/if}

<p class="comment_count">{'There are %d messages'|@translate|@sprintf:$COMMENT_COUNT}</p>

{if isset($comments)}
<div id="guestbookCommentList">
  {if !empty($navbar)}
    <div id="pictureCommentNavBar">
      {include file='navigation_bar.tpl'|@get_extent:'navbar'}
    </div>
  {/if}
  {include file=$ABS_GUESTBOOK_PATH|@cat:'template/comment_list.tpl'}
</div>
{/if}

{if $clear}<div style="clear: both;"></div>
</div>{/if}
</div>{* <!-- content --> *}
