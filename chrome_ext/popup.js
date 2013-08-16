
            $.getJSON('http://loginpal.herokuapp.com/sites.json', 'limit=1', processWebsites);
            function processWebsites(data) {
            var infoHTML='';



            $.each(data, function(website, websiteDetails) {
            infoHTML+= websiteDetails.username;
            infoHTML+= websiteDetails.pwhint;
            });

            $('#info').html(infoHTML);
            }
