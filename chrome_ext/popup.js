
            $.getJSON('http://loginpal.com/sites.json', 'limit=10', processWebsites);
            function processWebsites(data) {
            var infoHTML='';



            $.each(data, function(website, websiteDetails) {
            infoHTML+= websiteDetails.company;
            infoHTML+= websiteDetails.username;
            infoHTML+= websiteDetails.pwhint;
            });

            $('#info').html(infoHTML);
            }
