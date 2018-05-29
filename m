Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967697AbeE2XOR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 May 2018 19:14:17 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4TNDiBw020028
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 19:14:17 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j9ex1aqxe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 19:14:16 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 30 May 2018 00:14:14 +0100
Subject: Re: [PATCH v4 8/8] module: replace the existing LSM hook in
 init_module
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Date: Tue, 29 May 2018 19:14:05 -0400
In-Reply-To: <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
         <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527635645.3534.39.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-05-29 at 18:39 -0400, Paul Moore wrote:
[...]
> > @@ -4043,6 +4037,25 @@ static int selinux_kernel_module_from_file(struct file *file)
> >                                 SYSTEM__MODULE_LOAD, &ad);
> >  }
> >
> > +static int selinux_kernel_load_data(enum kernel_load_data_id id)
> > +{
> > +       u32 sid;
> > +       int rc = 0;
> > +
> > +       switch (id) {
> > +       case LOADING_MODULE:
> > +               sid = current_sid();
> > +
> > +               /* init_module */
> > +               return avc_has_perm(&selinux_state, sid, sid, SECCLASS_SYSTEM,
> > +                                   SYSTEM__MODULE_LOAD, NULL);
> > +       default:
> > +               break;
> > +       }
> > +
> > +       return rc;
> > +}
> 
> I'm not a fan of the duplication here.  If we must have a new LSM hook
> for this, can we at least have it call
> selinux_kernel_module_from_file() so we have all the kernel module
> loading logic/controls in one function?  Yes, I understand there are
> differences between init_module() and finit_module() but I like
> handling them both in one function as we do today.

There's some disagreement as to whether we really need two LSM hooks.
 This sounds like you would prefer a single LSM hook, not the two that
this patch set introduces.

We need to come to some consensus.  (Comments appreciated in 0/8.)

Mimi

> 
> >  static int selinux_kernel_read_file(struct file *file,
> >                                     enum kernel_read_file_id id)
> >  {
> > @@ -6950,6 +6963,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> >         LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
> >         LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
> >         LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
> > +       LSM_HOOK_INIT(kernel_load_data, selinux_kernel_load_data),
> >         LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
> >         LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
> >         LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
> > --
> > 2.7.5
> >
> 
