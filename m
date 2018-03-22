Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:28521 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754900AbeCVOUL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Mar 2018 10:20:11 -0400
Message-ID: <edcff887ff133df486812bb5ecadcc101bc1d227.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Sahil Rihan <srihan@fb.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Thu, 22 Mar 2018 16:20:06 +0200
In-Reply-To: <A799BB0A-C44B-41AB-9C38-4B974A50210D@fb.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
         <20180312150231.GA24717@ziepe.ca> <20180316125525.GB5035@linux.intel.com>
         <20180319021323.GD27186@ziepe.ca> <20180319212436.GD14364@linux.intel.com>
         <A799BB0A-C44B-41AB-9C38-4B974A50210D@fb.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-03-20 at 22:29 +0000, Sahil Rihan wrote:
> > On 3/19/18, 2:25 PM, "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>
> > wrote:
> >     
> >    Sahil, would you care to try if this fixes the issue that you are
> >    having or not?
> 
> Yes, we can test this out. Might take a day or two.

Awesome, thank you. I'll add

Reported-by: Sahil Rihan <srihan@fb.com>

if that is OK for you?

/Jarkko
