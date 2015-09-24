#! /usr/bin/env python3

# Copyright (c) 2014, Chris DeVisser
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#    1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
#
#    2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import html.parser, sys, urllib.parse, urllib.request

#Used to parse response text and look for the feedback
class FeedbackHTMLParser(html.parser.HTMLParser):
    isLookingForTextareaTag = False
    isLookingForTextareaData = False
    foundFeedback = False

    #Start looking for textarea content once "Feedback:" has been found
    def handle_starttag(self, tag, attrs):
        if self.isLookingForTextareaTag and tag == 'textarea':
            self.isLookingForTextareaData = True
            self.isLookingForTextareaTag = False

    def handle_endtag(self, tag):
        pass

    #Look for "Feedback:" first and then for the textarea content once the start tag for it has been found
    def handle_data(self, data):
        if 'Feedback:' in data:
            self.isLookingForTextareaTag = True

        if self.isLookingForTextareaData:
            print(data)
            self.foundFeedback = True
            self.isLookingForTextareaData = False


#There should be one command line argument: the .grg file
if len(sys.argv) != 2:
    print('Missing file argument.')
    sys.exit(0)

fileArg = sys.argv[1]

#Read the file
try:
    with open(fileArg, 'r') as file:
        text = file.read()
except:
    print('Problem reading file.')
    sys.exit(0)

#Post the file contents to George as the input script
try:
    url = 'https://www.student.cs.uwaterloo.ca/~se212/george/ask-george/george.cgi'
    data = urllib.parse.urlencode({
        'input_script': text.strip(),
        'check': 'Ask George',
        'filename': '',
        'download': '',
        'download_file_name': '',
        'uwid': '',
        'bug': ''
    }).encode('utf-8')

    request = urllib.request.Request(url)
    response = urllib.request.urlopen(request, data)
    html = response.read().decode('utf-8')
except:
    print('Problem getting George feedback.')
    sys.exit(0)

#Parse the returned HTML and make sure we find the feedback
htmlParser = FeedbackHTMLParser()
htmlParser.feed(html)

if not htmlParser.foundFeedback:
    print('No feedback found in response.')
