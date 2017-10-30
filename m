Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752642AbdJ3Pbx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 11:31:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9UFVq4N079271
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 11:31:52 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dx5sdvw6p-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 11:31:52 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 30 Oct 2017 15:31:49 -0000
Subject: Re: [RFC] EVM: Add support for portable signature format
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Mon, 30 Oct 2017 11:31:44 -0400
In-Reply-To: <CACdnJuvTEAs8tg2LoktmMRUzAMrfY5qTOeawTWCkvqit4A4huw@mail.gmail.com>
References: <20171026083144.16247-1-mjg59@google.com>
         <C2D7A727C393B644B70DF4B4DCFB60B921C471AC@FRAEML521-MBX.china.huawei.com>
         <1509367096.3583.70.camel@linux.vnet.ibm.com>
         <CACdnJuvTEAs8tg2LoktmMRUzAMrfY5qTOeawTWCkvqit4A4huw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1509377504.3583.97.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-10-30 at 13:17 +0000, Matthew Garrett wrote:
> On Mon, Oct 30, 2017 at 12:38 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Fri, 2017-10-27 at 10:41 +0000, Dmitry Kasatkin wrote:
> >
> >> > @@ -345,7 +350,8 @@ int evm_inode_setxattr(struct dentry *dentry, const
> >> > char *xattr_name,
> >> >     if (strcmp(xattr_name, XATTR_NAME_EVM) == 0) {
> >> >             if (!xattr_value_len)
> >> >                     return -EINVAL;
> >> > -           if (xattr_data->type != EVM_IMA_XATTR_DIGSIG)
> >> > +           if (xattr_data->type != EVM_IMA_XATTR_DIGSIG &&
> >> > +               xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG)
> >> >                     return -EPERM;
> >> >     }
> >>
> >> Also I have an impression that evm_protect_xattr will allow to set
> >> security.ima for example,
> >> And it will cause to try to re-calculate hmac over immutable
> >> signature...
> >
> > Right, it will allow evm_inode_post_setxattr() to replace the new file
> > signature with an HMAC.
> 
> evm_inode_setxattr() will call evm_protect_xattr(), which will call
> evm_verify_xattr(). This will return INTEGRITY_PASS_IMMUTABLE, which
> will result in evm_protect_xattr() returning -EPERM, so we never get
> to inode_post_setxattr().

Oh, I missed that.
