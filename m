Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751878AbdJYRS0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Oct 2017 13:18:26 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9PHHfli066402
        for <linux-integrity@vger.kernel.org>; Wed, 25 Oct 2017 13:18:26 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dtxfnset3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 25 Oct 2017 13:18:25 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 25 Oct 2017 18:18:23 +0100
Subject: Re: [PATCH v3 2/2] ima: check signature enforcement against cmdline
 param instead of CONFIG
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, serge@hallyn.com,
        james.l.morris@oracle.com, dmitry.kasatkin@gmail.com,
        rusty@rustcorp.com.au, jeyu@kernel.org
Date: Wed, 25 Oct 2017 13:18:17 -0400
In-Reply-To: <20171025150544.GC26762@glitch>
References: <cover.1508865786.git.brdeoliv@redhat.com>
         <b1bab0d1184f11c06ba0484883c22bc046ffb5a6.1508865786.git.brdeoliv@redhat.com>
         <1508885697.3164.5.camel@linux.vnet.ibm.com>
         <20171025150544.GC26762@glitch>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508951897.7367.16.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2017-10-25 at 13:05 -0200, Bruno E. O. Meneguele wrote:
> On 24-10, Mimi Zohar wrote:
> > On Tue, 2017-10-24 at 15:37 -0200, Bruno E. O. Meneguele wrote:
> > > When the user requests MODULE_CHECK policy and its kernel is compiled
> > > with CONFIG_MODULE_SIG_FORCE not set, all modules would not load, just
> > > those loaded in initram time. One option the user would have would be
> > > set a kernel cmdline param (module.sig_enforce) to true, but the IMA
> > > module check code doesn't rely on this value, it checks just
> > > CONFIG_MODULE_SIG_FORCE.
> > > 
> > > This patch solves this problem checking for the exported value of
> > > module.sig_enforce cmdline param intead of CONFIG_MODULE_SIG_FORCE,
> > > which holds the effective value (CONFIG || param).
> > > 
> > > Signed-off-by: Bruno E. O. Meneguele <brdeoliv@redhat.com>
> > > ---
> > >  security/integrity/ima/ima_main.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > > index e4ab8ef8016e..d11a7fcc5c8b 100644
> > > --- a/security/integrity/ima/ima_main.c
> > > +++ b/security/integrity/ima/ima_main.c
> > > @@ -356,12 +356,12 @@ void ima_post_path_mknod(struct dentry *dentry)
> > >   */
> > >  int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
> > >  {
> > > +	bool sig_enforce = is_module_sig_enforced();
> > > +
> > >  	if (!file && read_id == READING_MODULE) {
> > 
> > The only reason for getting here is that you're using the old module
> > load syscall.  Is there a reason for not using the new one, which
> > passes the file descriptor?

> Basicaly because the way kmod handles compressed (gz/xz) modules. The
> way it's today would require major changes in the code or some kind of
> memfd_create() + xattrs reassignement in order to finit_module() be used
> correctly.
> 
> Considering it would take some time to be accepted or even to figure out
> the correct way to tackle it, the current IMA module check code works
> aside kernel module signature validation, which is fine for now for me,
> but has the problem that this patch tries to solve in the
> CONFIG_MODULE_SIG_FORCE check (ignoring module.sig_enforce cmdline
> param).

Thank you for the reasoning.  BTW, these patches are now queued.


> > > -#ifndef CONFIG_MODULE_SIG_FORCE
> > > -		if ((ima_appraise & IMA_APPRAISE_MODULES) &&
> > > +		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
> > >  		    (ima_appraise & IMA_APPRAISE_ENFORCE))
> > >  			return -EACCES;	/* INTEGRITY_UNKNOWN */
> > > -#endif
> > >  		return 0;	/* We rely on module signature checking */
> > >  	}
> > >  	return 0;
> > 
> > 
> 
