Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43290 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751160AbeC0AH0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Mar 2018 20:07:26 -0400
From: Sahil Rihan <srihan@fb.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
Date: Tue, 27 Mar 2018 00:07:14 +0000
Message-ID: <49C2A39F-C9ED-4620-82C9-C0919DA3F2CD@fb.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
 <20180312150231.GA24717@ziepe.ca> <20180316125525.GB5035@linux.intel.com>
 <20180319021323.GD27186@ziepe.ca> <20180319212436.GD14364@linux.intel.com>
 <A799BB0A-C44B-41AB-9C38-4B974A50210D@fb.com>
 <edcff887ff133df486812bb5ecadcc101bc1d227.camel@linux.intel.com>
In-Reply-To: <edcff887ff133df486812bb5ecadcc101bc1d227.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> On 3/22/18, 7:20 AM, "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com> wrote:
>
>   On Tue, 2018-03-20 at 22:29 +0000, Sahil Rihan wrote:
>   > > On 3/19/18, 2:25 PM, "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>
>   > > wrote:
>   > >     
>   > >    Sahil, would you care to try if this fixes the issue that you are
>   > >    having or not?
>   > 
>   > Yes, we can test this out. Might take a day or two.
>    
>   Awesome, thank you. I'll add
>    
>   Reported-by: Sahil Rihan <srihan@fb.com>
>    
>   if that is OK for you?

Jarkko, 

We applied your patch to a 4.11 kernel (unfortunately not the latest upstream) and were able to confirm that the char device is now being created correctly. The sysfs enabled node is also present.

And yes, please add the "Reported-by" line.

Thanks,
Sahil
 
