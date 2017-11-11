Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:56828 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbdKKJiV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Nov 2017 04:38:21 -0500
Subject: Re: KEYS: trusted: Use common error handling code in trusted_update()
To: Julia Lawall <julia.lawall@lip6.fr>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <479805df-edaf-1e9a-57be-d7c4f38e9d31@users.sourceforge.net>
 <658d88c1-b29b-cf8c-2ce0-8a2755ec9f33@users.sourceforge.net>
 <alpine.DEB.2.20.1711102142220.2708@hadrien>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <a4ee27ee-a893-70c6-d40b-b1831ce62634@users.sourceforge.net>
Date: Sat, 11 Nov 2017 10:37:36 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1711102142220.2708@hadrien>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> Safe means that cleanup code should appear once in a cascade at the end
> of the function, to minimize the chance that anything will be overlooked.

I find that the control flow of this function implementation does not fit
to the mentioned ideal so far.


> Moving the ret assignments to the end of the function and adding the
> backward jumps doesn't make the code more understandable.

Is this structure required if you would like to achieve something
in the shown software design direction?


> On the other hand, moving the kzalloc of new_p to the end of the function
> could be helpful,

Why do you think that the movement of this function call can finally work
in the concrete software situation?


> because it reduces the chance that new error handling code,
> if any turns out to be needed, will forget this operation.

Your expectation can be nice.


> By why not just follow standard practice and free the structures in a
> cascade in the inverse of the order in which they are allocated at the end
> of the function?

This is still happening here partly, isn't it?


> There can be a descriptive label for each thing that needs to be freed.

Which identifiers would you find more appropriate in comparison to
my suggestion?

* e_inval
* e_nomem
* free_data
* free_payload

Regards,
Markus
