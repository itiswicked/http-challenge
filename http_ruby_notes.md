## notes

I decided to use ruby for this entire exercise.
Links to research and documentation used:

[Nokogiri Tutorials & Docs](http://www.nokogiri.org/)
[xPath Expressions](http://www.sitepoint.com/nokogiri-fundamentals-extract-html-web/)
[Net::HTTP Cheet Sheet](http://www.rubyinside.com/nethttp-cheat-sheet-2940.html)
[REST Client](https://github.com/rest-client/rest-client)

* Requesting Messages
  - For this portion, I decided to use:
   - NET::HTTP library for requesting the HTML page and strigifying it.
   - The Nokogiri gem for parsing the HTML page and getting something useful out of it
  - I passed my HTML string into a new Nokogiri::HTML object
    - To find the html elements where the time stamp and message info were, I used Nokogiri's xPath feature which, by accessing the right nodes, created 2 array like objects:
      - Timestamps
      - Message content
  - After I had these two arrays of data, I transormed them like any other array, and spit the content out to the console

* Post Messages
  - Posting messages was actually a little bit easier
  - I used RestClient, a gem for making simple HTTP requests.
    - To make the request using rest client:
      - I used Chrome's Network tab and to see my outgoing POST request while posting from the website.
      - This was useful for figuring what exactly the server expects from the form submission.
      - From there, I simply needed to pass RestClient#post:
        - The correct URL with the correct resources path.
        - The correct form content in a hash.
