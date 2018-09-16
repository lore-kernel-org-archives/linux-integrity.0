Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:38846 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728340AbeIQAtP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Sep 2018 20:49:15 -0400
Date: Sun, 16 Sep 2018 22:25:10 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, dunlapg@umich.edu,
        "Dr. Greg Wettstein" <greg@wind.enjellic.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Restore functionality to xen vtpm driver.
Message-ID: <20180916192510.GF7473@linux.intel.com>
References: <20180913212551.2435-1-boris.ostrovsky@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180913212551.2435-1-boris.ostrovsky@oracle.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Sep 13, 2018 at 05:25:51PM -0400, Boris Ostrovsky wrote:
> From: "Dr. Greg Wettstein" <greg@wind.enjellic.com>
> 
> Functionality of the xen-tpmfront driver was lost secondary to
> the introduction of xenbus multi-page support in commit ccc9d90a9a8b
> ("xenbus_client: Extend interface to support multi-page ring").
> 
> In this commit a pointer to the shared page address was being
> passed to the xenbus_grant_ring() function rather then the
> address of the shared page itself.  This resulted in a situation

I'm sorry but I'm far from being expert with Xen and this sentence
confuses me so maybe could open it up a bit.

For me "shared page address" and "address of the shared page" are
the same thing. What am I missing? I mean just different forms in
english to describe the exact same thing...

/Jarkko
