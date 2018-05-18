Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751545AbeERRzy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 May 2018 13:55:54 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4IHhZOP124214
        for <linux-integrity@vger.kernel.org>; Fri, 18 May 2018 13:55:53 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j236fh691-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 18 May 2018 13:55:53 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 18 May 2018 18:55:51 +0100
Subject: Re: [PATCH v2 3/9] security: define security_kernel_read_blob()
 wrapper
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>
Date: Fri, 18 May 2018 13:55:33 -0400
In-Reply-To: <alpine.LRH.2.21.1805190303100.26396@namei.org>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
         <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
         <87y3ghhbws.fsf@xmission.com>
         <alpine.LRH.2.21.1805190303100.26396@namei.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526666133.3404.67.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2018-05-19 at 03:13 +1000, James Morris wrote:
> On Thu, 17 May 2018, Eric W. Biederman wrote:
> 
> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > 
> > Nack on this sharing nonsense.  These two interfaces do not share any
> > code in their implementations other than the if statement to distinguish
> > between the two cases.
> 
> Hmm, it's not even doing that.
> 
> There's already an if(!file && read_id == X) { } check and this is another 
> one being added.
> 
> > If we want comprehensible and maintainable code in the security modules
> > we need to split these two pieces of functionality apart.
> 
> All ima_read is doing in both the old and new case is checking if there's 
> no file then if it's a certain operation, returning an error.
> 
> To echo Eric and Casey's suggestions, how about changing the name of the 
> hook to security_kernel_read_data() ?

Thanks, James.  Somehow I missed this option.  Renaming the existing
hook, would be the easiest solution.  Eric, are you in agreement with
James' naming suggestion/solution?

> Then ima_read_file() can be changed to ima_read_data(), and then instead 
> of two if (!file && read_id == X) checks, have:
> 
> 	if (!file) {
> 		switch (read_id) {
> 		}
> 	}
> 
> 
> 
> 
