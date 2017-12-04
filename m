Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:36100 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751200AbdLDXfn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Dec 2017 18:35:43 -0500
Message-ID: <1512430537.6321.58.camel@perches.com>
Subject: Re: [PATCH v2] ima: log message to module appraisal error
From: Joe Perches <joe@perches.com>
To: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org,
        linux-ima-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 Dec 2017 15:35:37 -0800
In-Reply-To: <20171204202347.16261-1-brdeoliv@redhat.com>
References: <20171204202347.16261-1-brdeoliv@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-12-04 at 18:23 -0200, Bruno E. O. Meneguele wrote:
> Simple but useful message log to the user in case of module appraise is
> forced and fails due to the lack of file descriptor, that might be
> caused by kmod calls to compressed modules.
[]
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
[]
> @@ -366,8 +366,12 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>  
>  	if (!file && read_id == READING_MODULE) {
>  		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
> -		    (ima_appraise & IMA_APPRAISE_ENFORCE))
> +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> +			pr_err("impossible to appraise a module without a file \
> +			       descriptor. sig_enforce kernel parameter might \
> +			       help\n");
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You should probably use scripts/checkpatch.pl on your proposed
patches
before sending them.

You've got a lot of tabs and spaces after every line continuation.
Please coalesce the format on a single line and avoid this defect.

			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");

cheers, Joe
