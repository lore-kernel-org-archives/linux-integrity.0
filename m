Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9561 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbdJRQAB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 12:00:01 -0400
Date: Wed, 18 Oct 2017 18:59:46 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Kenneth Goldman <kgold@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: char/tpm: Improve a size determination in nine functions
Message-ID: <20171018155946.e7ga7jyex6eia252@linux.intel.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
 <1508238182.16112.475.camel@linux.intel.com>
 <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
 <1508244757.4234.60.camel@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710171456360.5035@hadrien>
 <1508253453.4234.81.camel@linux.vnet.ibm.com>
 <9689f036-ba9f-d23b-cf89-c289bc308771@users.sourceforge.net>
 <20171018145735.lpzwakatsty7emlw@linux.intel.com>
 <351cf78a-14f6-c6e7-2902-048e7dc57a14@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <351cf78a-14f6-c6e7-2902-048e7dc57a14@users.sourceforge.net>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 18, 2017 at 05:22:19PM +0200, SF Markus Elfring wrote:
> >> Do you find my wording "This issue was detected by using the
> >> Coccinelle software." insufficient?
> > 
> > This is fine for cover letter, not for the commits.
> 
> I guess that there are more opinions available by other contributors
> for this aspect.
> 
> 
> > After your analysis software finds an issue you should manually analyze
> > what is wrong
> 
> This view is generally fine.
> 
> 
> > and document that to the commit message.
> 
> I tried it in a single paragraph so far (besides the reference
> for the tool).
> 
> 
> > This applies to sparse, coccinelle or any other tool.
> 
> I find that further possibilities can be considered.
> 
> 
> > Tool-based commit messages are bad for commit history
> 
> I disagree to this view.
> 
> 
> > where as clean description gives idea what was done
> > (if you have to maintain a GIT tree).
> 
> How do you think about to offer any wording for an alternative
> which you would find better?
> 
> 
> > In my opinion tool is doing all the work but the part
> > that you should do is absent.
> 
> Really?
> 
> Regards,
> Markus

Commit message should just describe in plain text what you are doing
and why.

/Jarkko
