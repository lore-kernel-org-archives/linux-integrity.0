Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33047 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751116AbeEDADB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 May 2018 20:03:01 -0400
Date: Fri, 4 May 2018 00:02:58 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Jones <pjones@redhat.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/6] firmware: permit LSMs and IMA to fail firmware sysfs
 fallback loading
Message-ID: <20180504000258.GP27853@wotan.suse.de>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1525182503-13849-2-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525182503-13849-2-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

If you can add Andres Rodriguez <andresx7@gmail.com>, and Greg to your Cc list
in the future patches that'd be appreciated.

On Tue, May 01, 2018 at 09:48:18AM -0400, Mimi Zohar wrote:
> Add an LSM hook prior to allowing firmware sysfs fallback loading.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Matthew Garrett <mjg59@google.com>
> ---
>  drivers/base/firmware_loader/fallback.c | 7 +++++++
>  include/linux/fs.h                      | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 31b5015b59fe..23d2af30474e 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -651,6 +651,8 @@ static bool fw_force_sysfs_fallback(unsigned int opt_flags)
>  
>  static bool fw_run_sysfs_fallback(unsigned int opt_flags)
>  {
> +	int ret;
> +
>  	if (fw_fallback_config.ignore_sysfs_fallback) {
>  		pr_info_once("Ignoring firmware sysfs fallback due to sysctl knob\n");
>  		return false;
> @@ -659,6 +661,11 @@ static bool fw_run_sysfs_fallback(unsigned int opt_flags)
>  	if ((opt_flags & FW_OPT_NOFALLBACK))
>  		return false;
>  
> +	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
> +	ret = security_kernel_read_file(NULL, READING_FIRMWARE_FALLBACK);
> +	if (ret < 0)
> +		return ret;
> +
>  	return fw_force_sysfs_fallback(opt_flags);
>  }
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 760d8da1b6c7..dc16a73c3d38 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2810,6 +2810,7 @@ extern int do_pipe_flags(int *, int);
>  	id(UNKNOWN, unknown)		\
>  	id(FIRMWARE, firmware)		\
>  	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
> +	id(FIRMWARE_FALLBACK, firmware)	\

If you're going to add this perhaps FIRMWARE_FALLBACK_SYSFS as we may later
get FIRMWARE_FALLBACK_EFI.

  Luis
