Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750854AbdJOO2S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 15 Oct 2017 10:28:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9FEOPvo143608
        for <linux-integrity@vger.kernel.org>; Sun, 15 Oct 2017 10:28:18 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dkf4h3hnp-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 15 Oct 2017 10:28:18 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 15 Oct 2017 15:28:16 +0100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9FESB3R27984084
        for <linux-integrity@vger.kernel.org>; Sun, 15 Oct 2017 14:28:12 GMT
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
        by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9FES2jX010446
        for <linux-integrity@vger.kernel.org>; Mon, 16 Oct 2017 01:28:02 +1100
Subject: Re: [PATCH] EVM: Include security.apparmor in EVM measurements
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: John Johansen <john.johansen@canonical.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity@vger.kernel.org
Date: Sun, 15 Oct 2017 10:28:07 -0400
In-Reply-To: <eaabb1e3-4cfe-653b-a1a8-8dabd5f24e06@canonical.com>
References: <20171013220925.6420-1-mjg59@google.com>
         <eaabb1e3-4cfe-653b-a1a8-8dabd5f24e06@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508077687.3426.144.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-10-13 at 16:36 -0700, John Johansen wrote:
> On 10/13/2017 03:09 PM, Matthew Garrett wrote:
> > Apparmor will be gaining support for security.apparmor labels, and it
> > would be helpful to include these in EVM validation now so appropriate
> > signatures can be generated even before full support is merged.
> > 
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
> Acked-by: John Johansen <John.johansen@canonical.com>

Thanks!

> 
> > ---
> >  include/uapi/linux/xattr.h        | 3 +++
> >  security/integrity/evm/evm_main.c | 3 +++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
> > index 1590c49cae57..e630b9cd70cb 100644
> > --- a/include/uapi/linux/xattr.h
> > +++ b/include/uapi/linux/xattr.h
> > @@ -65,6 +65,9 @@
> >  #define XATTR_NAME_SMACKTRANSMUTE XATTR_SECURITY_PREFIX XATTR_SMACK_TRANSMUTE
> >  #define XATTR_NAME_SMACKMMAP XATTR_SECURITY_PREFIX XATTR_SMACK_MMAP
> >  
> > +#define XATTR_APPARMOR_SUFFIX "apparmor"
> > +#define XATTR_NAME_APPARMOR XATTR_SECURITY_PREFIX XATTR_APPARMOR_SUFFIX
> > +
> >  #define XATTR_CAPS_SUFFIX "capability"
> >  #define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
> >  
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > index 40bf3a20605d..78a5b1fddfc7 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -49,6 +49,9 @@ char *evm_config_xattrnames[] = {
> >  	XATTR_NAME_SMACKMMAP,
> >  #endif
> >  #endif
> > +#ifdef CONFIG_SECURITY_APPARMOR
> > +	XATTR_NAME_APPARMOR,
> > +#endif
> >  #ifdef CONFIG_IMA_APPRAISE
> >  	XATTR_NAME_IMA,
> >  #endif
> > 
> 
