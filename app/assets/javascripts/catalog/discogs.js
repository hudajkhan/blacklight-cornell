// For musical recordings, used to bring in metadata from the Discogs site.
var remote = true;
getDiscogsDetails(discogs_id)
function getDiscogsDetails(id) {
    $.ajax({
      url : "/get_discogs?id=" + id,
      type: 'GET',
      data: remote,
      complete: function(xhr, status) {
          // console.log("getDiscogsDetails complete");
      }
    }); 
}
