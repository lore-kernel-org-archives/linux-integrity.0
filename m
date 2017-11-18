Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from h2.hallyn.com ([78.46.35.8]:57700 "EHLO h2.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935453AbdKREZz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Nov 2017 23:25:55 -0500
Date: Fri, 17 Nov 2017 22:25:53 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v2 12/15] ima: do not update security.ima if appraisal
 status is not INTEGRITY_PASS
Message-ID: <20171118042553.GB13456@mail.hallyn.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
 <20171107103710.10883-13-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171107103710.10883-13-roberto.sassu@huawei.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 07, 2017 at 11:37:07AM +0100, Roberto Sassu wrote:
> Commit b65a9cfc2c38 ("Untangling ima mess, part 2: deal with counters")
> moved the call of ima_file_check() from may_open() to do_filp_open() at a
> point where the file descriptor is already opened.
> 
> This breaks the assumption made by IMA that file descriptors being closed
> belong to files whose access was granted by ima_file_check(). The
> consequence is that security.ima and security.evm are updated with good
> values, regardless of the current appraisal status.
> 
> For example, if a file does not have security.ima, IMA will create it after
> opening the file for writing, even if access is denied. Access to the file
> will be allowed afterwards.
> 
> Avoid this issue by checking the appraisal status before updating
> security.ima.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

IIUC this seems like a huge deal.  Shouldn't this go in separately, asap?

> ---
>  security/integrity/ima/ima_appraise.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 285a53452fb5..1b2236e637ff 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -320,6 +320,9 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
>  	if (iint->flags & IMA_DIGSIG)
>  		return;
>  
> +	if (iint->ima_file_status != INTEGRITY_PASS)
> +		return;
> +
>  	rc = ima_collect_measurement(iint, file, NULL, 0, ima_hash_algo);
>  	if (rc < 0)
>  		return;
> -- 
> 2.11.0
