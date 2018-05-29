Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46694 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937145AbeE2VHW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 May 2018 17:07:22 -0400
Received: by mail-lf0-f67.google.com with SMTP id h9-v6so915133lfc.13
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 14:07:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180524201105.3179904-4-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com> <20180524201105.3179904-4-stefanb@linux.vnet.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 May 2018 17:07:19 -0400
Message-ID: <CAHC9VhRjYhSgd_YCmgaOU_MEKuNKbHvPCVotmxyZRzSc2E6-Wg@mail.gmail.com>
Subject: Re: [PATCH 3/8] audit: Implement audit_log_tty()
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: zohar@linux.vnet.ibm.com, sgrubb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, May 24, 2018 at 4:11 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Implement audit_log_tty() so that IMA can add tty= to its audit records.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  include/linux/audit.h | 5 +++++
>  kernel/audit.c        | 8 ++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 90aa63ddc9be..2deb76c74d10 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -154,6 +154,7 @@ extern void audit_log_task_info(struct audit_buffer *ab,
>                                 struct task_struct *tsk);
>
>  extern int                 audit_update_lsm_rules(void);
> +extern void audit_log_tty(struct audit_buffer *ab, struct task_struct *tsk);
>
>                                 /* Private API (for audit.c only) */
>  extern int audit_rule_change(int type, int seq, void *data, size_t datasz);
> @@ -202,6 +203,10 @@ static inline int audit_log_task_context(struct audit_buffer *ab)
>  static inline void audit_log_task_info(struct audit_buffer *ab,
>                                        struct task_struct *tsk)
>  { }
> +
> +static inline void audit_log_tty(struct audit_buffer *ab,
> +                                struct task_struct *tsk)
> +{ }
>  #define audit_enabled 0
>  #endif /* CONFIG_AUDIT */
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 670665c6e2a6..fa54695962b4 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2305,6 +2305,14 @@ void audit_log_task_info(struct audit_buffer *ab, struct task_struct *tsk)
>  }
>  EXPORT_SYMBOL(audit_log_task_info);
>
> +void audit_log_tty(struct audit_buffer *ab, struct task_struct *tsk)
> +{
> +       struct tty_struct *tty = audit_get_tty(tsk);
> +
> +       audit_log_format(ab, " tty=%s", tty ? tty_name(tty) : "(none)");
> +       audit_put_tty(tty);
> +}

Perhaps I missed it, but your IMA patches only ever call this to log
current's tty, yes?  If so, I would prefer if we dropped the
task_struct argument and always had audit_log_tty() use current.

-- 
paul moore
www.paul-moore.com
