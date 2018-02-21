Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751376AbeBUXDX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Feb 2018 18:03:23 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1LMnHMv069177
        for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2018 18:03:23 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g9eg87wm8-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2018 18:03:22 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 21 Feb 2018 23:03:20 -0000
Subject: Re: [PATCH v1 1/2] ima: fail signature verification on untrusted
 filesystems
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: James Morris <jmorris@namei.org>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E . Hallyn" <serge@hallyn.com>
Date: Wed, 21 Feb 2018 18:03:13 -0500
In-Reply-To: <87fu5uc5ug.fsf@xmission.com>
References: <1519053483-18396-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
         <87zi44mz26.fsf@xmission.com>  <alpine.LRH.2.21.1802201152240.883@namei.org>
         <87tvucifji.fsf@xmission.com>  <1519135329.3736.88.camel@linux.vnet.ibm.com>
         <87fu5uc5ug.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1519254193.19593.32.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-02-21 at 16:53 -0600, Eric W. Biederman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> 
> > On Mon, 2018-02-19 at 20:02 -0600, Eric W. Biederman wrote:
> >> It would also be nice if I could provide all of this information at
> >> mount time (when I am the global root) with mount options.  So I don't
> >> need to update all of my tooling to know how to update ima policy when I
> >> am mounting a filesystem.
> >
> > The latest version of this patch relies on a builtin IMA policy to set
> > a flag.  No other changes are required to the IMA policy.  This
> > builtin policy could be used for environments not willing to accept
> > the default unverifiable signature risk.
> 
> I still remain puzzled by this.  Why is the default to accept the risk?

Accepting the risk is option 2, the privileged mount scenario.  It
requires re-evaluating the cached info.

Mimi
