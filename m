Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17920 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933479AbeCGQHs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Mar 2018 11:07:48 -0500
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "\"linux-security-module@vger.kernel.org\\\"
        <linux-security-module@vger.kernel.org>, \"@lwn.net"
        <"linux-security-module@vger.kernel.org\" <linux-security-module@vger.kernel.org>, "@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "\" <linux-kernel@vger.kernel.org>\"@lwn.net"
        <" <linux-kernel@vger.kernel.org>"@lwn.net>
Subject: RE: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Date: Wed, 7 Mar 2018 16:04:02 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9423018C@hasmsx108.ger.corp.intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
        <20180305125642.GA3425@linux.intel.com>
        <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
        <20180306074932.GB3624@linux.intel.com>
        <5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
        <1520353933.5393.21.camel@HansenPartnership.com>
        <1520361396.10396.396.camel@linux.vnet.ibm.com>
 <20180307085454.2c820a13@lwn.net>
In-Reply-To: <20180307085454.2c820a13@lwn.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


> 
> On Tue, 06 Mar 2018 13:36:36 -0500
> Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > I've heard that some maintainers are moving away from cover letters,
> > since they are not include in the git repo and are lost.
> 
> If I get a patch series with a cover letter that should be preserved, I apply the
> series in a branch then do a no-ff merge; the cover letter can then go into
> the merge commit.  There's no reason why cover letters need to be lost.

That's clever, but still it feels like a hack. 
I've try to keep cover letters as an empty commits for that but it has to be always forced when rebasing.
Not sure git has a real user friendly support for that.

Tomas
