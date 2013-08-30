
$.getJSON('http://loginpal.com/sites.json', 'limit=150', processWebsites);
function processWebsites(data) {
var infoHTML='';





$.each(data.sites, function(website, websiteDetails) {

infoHTML+= "<tr class='rowhover'><td class='company'>" + '<img src=' + websiteDetails.favicon + '> ' + websiteDetails.company + "</td>"
infoHTML+= "<td class='username'>" + websiteDetails.username + "</td>"
infoHTML+= "<td class='pwhint'>" + websiteDetails.pwhint + "</td></tr>";
});


$('#info').html(infoHTML);

}


