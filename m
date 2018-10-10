Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726908AbeJKC2U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Oct 2018 22:28:20 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9AIwmCm066631
        for <linux-integrity@vger.kernel.org>; Wed, 10 Oct 2018 15:04:50 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n1ntd3jkj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 10 Oct 2018 15:04:50 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 10 Oct 2018 20:04:48 +0100
Subject: Re: [PATCH v2] Open a new file instance if no read permissions
From: Mimi Zohar <zohar@linux.ibm.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>,
        James Morris <jmorris@namei.org>
Cc: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        iforster@suse.de, fvogt@suse.de, miklos@szeredi.hu
Date: Wed, 10 Oct 2018 15:04:42 -0400
In-Reply-To: <20181009151233.lxgm5c73epofi6r3@merlin>
References: <20181009151233.lxgm5c73epofi6r3@merlin>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1539198282.3585.6.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Goldwyn,

On Tue, 2018-10-09 at 10:12 -0500, Goldwyn Rodrigues wrote:
> Open a new file instance as opposed to changing file->f_mode when
> the file is not readable. This is done to accomodate
> overlayfs stacked file operations change. The real struct file is hidden
> behind the overlays struct file. So, any file->f_mode manipulations are
> not reflected on the real struct file. Open the file again in read mode
> if original file cannot be read, read and calculate the hash.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Thanks!  I'm waiting for it to hit linux-next, before sending James
the linux-integrity pull request.

Mimi
