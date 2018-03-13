Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752675AbeCMUkl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Mar 2018 16:40:41 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2DKeWtB043801
        for <linux-integrity@vger.kernel.org>; Tue, 13 Mar 2018 16:40:40 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gpn8p9fg4-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 13 Mar 2018 16:40:39 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 13 Mar 2018 20:40:14 -0000
Subject: Re: [PATCH v3 0/4] unverifiable file signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date: Tue, 13 Mar 2018 16:40:10 -0400
In-Reply-To: <87zi3bwyql.fsf@xmission.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
         <87zi3bwyql.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1520973610.3547.366.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-03-13 at 14:40 -0500, Eric W. Biederman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> 
> > For local filesystems, the kernel prevents files being executed from
> > being modified.  With IMA-measurement enabled, the kernel also emits
> > audit "time of measure, time of use" messages for files opened for
> > read, and subsequently opened for write.
> >
> > Files on fuse are initially measured, appraised, and audited.  Although
> > the file data can change dynamically any time, making re-measuring,
> > re-appraising, or re-auditing pointless, this patch set attempts to
> > differentiate between unprivileged non-init root and privileged
> > mounted fuse filesystems.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Overall ack on the way this is put together.

Thanks you!

Mimi
