Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43830 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727499AbeGSVMP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Jul 2018 17:12:15 -0400
Message-ID: <1532032049.3061.1.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: add support for partial reads
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>,
        jarkko.sakkinen@linux.intel.com
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Jul 2018 13:27:29 -0700
In-Reply-To: <0b9f0bb5-6620-0499-6680-5ec595167f23@intel.com>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
         <1532020750.5396.4.camel@HansenPartnership.com>
         <421c4b75-9e9d-7045-adad-797fd112898a@intel.com>
         <1532026030.3198.2.camel@HansenPartnership.com>
         <e8c17a40-7e5e-61e9-7088-32817766b614@intel.com>
         <1532029979.3198.4.camel@HansenPartnership.com>
         <0b9f0bb5-6620-0499-6680-5ec595167f23@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-07-19 at 13:12 -0700, Tadeusz Struk wrote:
> On 07/19/2018 12:52 PM, James Bottomley wrote:
> > The ABI break is the error case as I outlined above.  We can't
> > assume everyone uses the current interface without getting an error
> > and one error and your hosed is a nasty failure case to change the
> > interface to. 
> 
> Well, if there is a broken application out there that doesn't work
> today it will not work after this change neither.

It doesn't have to be broken ... it could be using EFAULT to probe the
buffer size for instance.  That's the point of not breaking the ABI:
you don't second guess what applications are doing.

James
