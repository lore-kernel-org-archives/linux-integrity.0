Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39341 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeFAW0Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Jun 2018 18:26:24 -0400
Received: by mail-lf0-f67.google.com with SMTP id t134-v6so16919479lff.6
        for <linux-integrity@vger.kernel.org>; Fri, 01 Jun 2018 15:26:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527781658.3427.25.camel@linux.vnet.ibm.com>
References: <20180515173826.21114-1-mjg59@google.com> <1527781658.3427.25.camel@linux.vnet.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 Jun 2018 18:26:21 -0400
Message-ID: <CAHC9VhSrMW_6Y6bxeqPMOo+cE25kUc=Tksq+KeXCvwUPWFTwmg@mail.gmail.com>
Subject: Re: [PATCH V6] EVM: Allow runtime modification of the set of verified xattrs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Matthew Garrett <mjg59@google.com>,
        linux-integrity@vger.kernel.org, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, May 31, 2018 at 11:47 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Hi Matthew,
>
> On Tue, 2018-05-15 at 10:38 -0700, Matthew Garrett wrote:
>
> Based on the "IMA: work on audit records produced by IMA" discussion,
> should this new audit record be adding the task info by calling
> "audit_log_task_info(ab, current);" too?

Independent of what info Steve decides he wants in the
AUDIT_INTEGRITY_EVM_XATTR record, the first parameter to
audit_log_start() should be either audit_context() (heading to Linus
during the upcoming merge window) or current->context if this goes in
before then (it doesn't look like it given the timing of things).

> Could you provide Steve with an example of the audit rule?
>
> thanks!
>
> Mimi
>
> [...]
>
>> +/**
>> + * evm_write_xattrs - write() for <securityfs>/evm_xattrs
>> + * @file: file pointer, not actually used
>> + * @buf: where to get the data from
>> + * @count: bytes sent
>> + * @ppos: where to start
>> + *
>> + * Returns number of bytes written or error code, as appropriate
>> + */
>> +static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
>> +                             size_t count, loff_t *ppos)
>> +{
>> +     int len, err;
>> +     struct xattr_list *xattr, *tmp;
>> +     struct audit_buffer *ab;
>> +     struct iattr newattrs;
>> +     struct inode *inode;
>> +
>> +     if (!capable(CAP_SYS_ADMIN) || evm_xattrs_locked)
>> +             return -EPERM;
>> +
>> +     if (*ppos != 0)
>> +             return -EINVAL;
>> +
>> +     if (count > XATTR_NAME_MAX)
>> +             return -E2BIG;
>> +
>> +     ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_EVM_XATTR);
>> +     if (IS_ERR(ab))
>> +             return PTR_ERR(ab);
>> +
>> +     xattr = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
>> +     if (!xattr) {
>> +             err = -ENOMEM;
>> +             goto out;
>> +     }
>> +
>> +     xattr->name = memdup_user_nul(buf, count);
>> +     if (IS_ERR(xattr->name)) {
>> +             err = PTR_ERR(xattr->name);
>> +             xattr->name = NULL;
>> +             goto out;
>> +     }
>> +
>> +     /* Remove any trailing newline */
>> +     len = strlen(xattr->name);
>> +     if (xattr->name[len-1] == '\n')
>> +             xattr->name[len-1] = '\0';
>> +
>> +     if (strcmp(xattr->name, ".") == 0) {
>> +             evm_xattrs_locked = 1;
>> +             newattrs.ia_mode = S_IFREG | 0440;
>> +             newattrs.ia_valid = ATTR_MODE;
>> +             inode = evm_xattrs->d_inode;
>> +             inode_lock(inode);
>> +             err = simple_setattr(evm_xattrs, &newattrs);
>> +             inode_unlock(inode);
>> +             audit_log_format(ab, "locked");
>> +             if (!err)
>> +                     err = count;
>> +             goto out;
>> +     }
>> +
>> +     audit_log_format(ab, "xattr=");
>> +     audit_log_untrustedstring(ab, xattr->name);
>> +
>> +     if (strncmp(xattr->name, XATTR_SECURITY_PREFIX,
>> +                 XATTR_SECURITY_PREFIX_LEN) != 0) {
>> +             err = -EINVAL;
>> +             goto out;
>> +     }
>> +
>> +     /* Guard against races in evm_read_xattrs */
>> +     mutex_lock(&xattr_list_mutex);
>> +     list_for_each_entry(tmp, &evm_config_xattrnames, list) {
>> +             if (strcmp(xattr->name, tmp->name) == 0) {
>> +                     err = -EEXIST;
>> +                     mutex_unlock(&xattr_list_mutex);
>> +                     goto out;
>> +             }
>> +     }
>> +     list_add_tail_rcu(&xattr->list, &evm_config_xattrnames);
>> +     mutex_unlock(&xattr_list_mutex);
>> +
>> +     audit_log_format(ab, " res=0");
>> +     audit_log_end(ab);
>> +     return count;
>> +out:
>> +     audit_log_format(ab, " res=%d", err);
>> +     audit_log_end(ab);
>> +     kfree(xattr->name);
>> +     kfree(xattr);
>> +     return err;
>> +}
>



-- 
paul moore
www.paul-moore.com
