
$.getJSON('http://www.loginpal.com/sites.json', 'limit=150', processWebsites);
function processWebsites(data) {
var infoHTML='';

// var go_to='Please login or sign up at loginpal.com!';

// if (data === nil) {
  // $('#go_to').html(go_to)
// }


$.each(data.sites, function(website, websiteDetails) {

infoHTML+= "<tr class='rowhover'><td class='company'>" + "<a href='" + websiteDetails.site + "'" + "target='_blank'" + ">" + '<img src=' + websiteDetails.favicon + '> ' + websiteDetails.company + "</a>"  + "</td>"
infoHTML+= "<td class='username'>" + websiteDetails.username + "</td>"
infoHTML+= "<td class='pwhint'>" + websiteDetails.pwhint + "</td></tr>";
});


$('#info').html(infoHTML);

}


